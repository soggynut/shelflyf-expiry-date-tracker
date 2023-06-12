import 'package:flutter/material.dart';
import 'dart:async'; // Import the Timer class
import 'database_helper.dart';
import 'succes.dart';

class ProductNameScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final String expirationDate;
  //final String validUpTo; // add validUpTo parameter
// Define the expirationDate parameter

  ProductNameScreen({super.key,
    required this.expirationDate,
    //required this.validUpTo,
  });

  Future<void> _onDonePressed(BuildContext context) async {
    String productName = _textEditingController.text;

    int insertedId = await DatabaseHelper.instance
        .insertProduct(productName, expirationDate);
    if (insertedId > 0) {
      // Product name inserted successfully
      print('Product name inserted with ID: $insertedId');
    } else {
      // Failed to insert product name
      print('Failed to insert product name');
    }

    Timer(Duration(seconds: 1), () {
      // Wait for 1 second and then navigate to MyShelfScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the product name:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _textEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Product name',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _onDonePressed(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 217, 217, 217),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
