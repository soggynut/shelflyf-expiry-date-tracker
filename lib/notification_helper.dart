import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializeNotifications(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Handle notification click event
    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
    );
  }

  static Future<void> insertProductWithNotification(
      BuildContext context, Product product) async {
    // Insert the product into the database
    await insertIntoDatabase(product);

    // Schedule a notification for the inserted product
    final location =
        tz.getLocation('Asia/Kolkata'); // Replace with your desired time zone
    final now = tz.TZDateTime.now(location);
    final scheduledDate = now.add(const Duration(seconds: 3));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      product.id,
      'Product Expiration',
      'The product ${product.name} is expiring soon.',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload:
          product.id.toString(), // Optional payload to identify the product
    );
  }

  static Future<void> insertIntoDatabase(Product product) async {
    // Replace this with your actual database insertion logic
    // Simulate inserting the product into the database with a delay
    await Future.delayed(const Duration(seconds: 2));
    print('Product inserted into the database: ${product.name}');
  }
}

class Product {
  final int id;
  final String name;
  final DateTime expirationDate;

  Product({required this.id, required this.name, required this.expirationDate});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize notifications
    NotificationHelper.initializeNotifications(context);

    // Simulate scanning the expiry date and storing the product in the database
    final scannedExpiryDate = DateTime.now().add(Duration(days: 2));
    final product = Product(
      id: 1,
      name: 'Scanned Product',
      expirationDate: scannedExpiryDate,
    );

    // Insert the product and schedule the notification
    NotificationHelper.insertProductWithNotification(context, product);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Example'),
        ),
        body: const Center(
          child: Text('Check the console for notification details.'),
        ),
      ),
    );
  }
}
