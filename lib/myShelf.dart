/*
import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'myHome.dart';

class MyShelfScreen extends StatefulWidget {
  final String extractedDate;
  final String productName;

  MyShelfScreen({
    required this.extractedDate,
    required this.productName,
  });
  @override
  _MyShelfScreenState createState() => _MyShelfScreenState();
}

class _MyShelfScreenState extends State<MyShelfScreen> {
  List<Map<String, dynamic>> products = [];

  void _deleteProduct(int index) async {
    final product = products[index];
    final productId = product[DatabaseHelper.columnId];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await DatabaseHelper.instance.deleteProduct(productId);
                _fetchProducts();
                Navigator.of(context).pop();
                print('Product with ID $productId deleted successfully!');
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchProducts() async {
    List<Map<String, dynamic>> productList =
        await DatabaseHelper.instance.queryAll();

    setState(() {
      products = productList;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shelf'),
        backgroundColor: Color.fromARGB(255, 44, 150, 156),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doodle2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final productName = product['pname'];
                    final expiryDate = product['expdate'];

                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(225, 217, 217, 217),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.shelves),
                        title: Text(productName),
                        subtitle: Text('Expiry Date: $expiryDate'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteProduct(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'database_helper.dart';
import 'myHome.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyShelfScreen extends StatefulWidget {
  final String extractedDate;
  final String productName;

  MyShelfScreen({
    required this.extractedDate,
    required this.productName,
  });

  @override
  _MyShelfScreenState createState() => _MyShelfScreenState();
}

class _MyShelfScreenState extends State<MyShelfScreen> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // Initialize time zones
    _initializeNotifications();
    _fetchProducts();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(
      String productName, DateTime expirationDate) async {
    final location =
        tz.getLocation('Asia/Kolkata'); // Replace with your desired time zone
    final scheduledDate = tz.TZDateTime.from(expirationDate, location);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Product Expiration',
        'The product $productName is expiring soon.',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  void _deleteProduct(int index) async {
    final product = products[index];
    final productId = product[DatabaseHelper.columnId];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await DatabaseHelper.instance.deleteProduct(productId);
                _fetchProducts();
                Navigator.of(context).pop();
                print('Product with ID $productId deleted successfully!');
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchProducts() async {
    List<Map<String, dynamic>> productList =
        await DatabaseHelper.instance.queryAll();

    setState(() {
      products = productList;
    });

    // Schedule notifications for each product
    for (final product in products) {
      final productName = product['pname'];
      final expiryDate = DateTime.parse(product['expdate']);

      final notificationDate10DaysPrior =
          expiryDate.subtract(Duration(days: 10));
      final notificationDate5DaysPrior = expiryDate.subtract(Duration(days: 5));
      final notificationDate1DaysPrior = expiryDate.subtract(Duration(days: 1));
      await _scheduleNotification(productName, notificationDate10DaysPrior);
      await _scheduleNotification(productName, notificationDate5DaysPrior);
      await _scheduleNotification(productName, notificationDate1DaysPrior);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shelf'),
        backgroundColor: Color.fromARGB(255, 44, 150, 156),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doodle2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final productName = product['pname'];
                    final expiryDate = product['expdate'];

                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(225, 217, 217, 217),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.shelves),
                        title: Text(productName),
                        subtitle: Text('Expiry Date: $expiryDate'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteProduct(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
