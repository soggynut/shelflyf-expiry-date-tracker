/* import 'package:flutter/material.dart';
import 'myShelf.dart';



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: <Color>[Color(0xff000000), Color(0x004d4d4d)],
                stops: <double>[0, 1],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/backgrnd.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(53, 77, 46, 83.66),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(3, 0, 0, 9),
                        width: double.infinity,
                        height: 78,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 45,
                              height: 49,
                              child: Image.asset(
                                'assets/images/LOGO.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 14),
                                    child: TextButton(
                                      onPressed: () {
                                         Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyShelfScreen()),
                );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 56,
                                        height: 59,
                                        child: Image.asset(
                                          'assets/images/shelf.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    width: 236,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 185, 199),
                        child: const Text(
                          'Good Afternoon!',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(45, 0, 28, 17),
                        width: double.infinity,
                        height: 192,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1,
                              top: 0,
                              child: Align(
                                child: SizedBox(
                                  width: 235,
                                  height: 186.27,
                                  child: Image.asset(
                                    'assets/images/dimsums.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 258,
                                height: 192,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 8, 49),
                        child: const Text(
                          'Let’s add your first item',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                          width: 65,
                          height: 56.34,
                          child: Image.asset(
                            'assets/images/arrowhome.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 154,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 58,
                        child: Align(
                          child: SizedBox(
                            width: 451,
                            height: 96,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfffff5db),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 154,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 120,
                            height: 115,
                            child: Image.asset(
                              'assets/images/shelf.png',
                              width: 120,
                              height: 115,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 47,
                        top: 74,
                        child: Align(
                          child: SizedBox(
                            width: 30,
                            height: 21,
                            child: Text(
                              'help',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4e4e4e),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 179,
                        top: 24,
                        child: Align(
                          child: SizedBox(
                            width: 72,
                            height: 72,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Image.asset(
                                'assets/images/shelf.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 340,
                        top: 69,
                        child: Align(
                          child: SizedBox(
                            width: 32.83,
                            height: 32.83,
                            child: Image.asset(
                              'assets/images/shelf.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 226, 197, 117),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'myShelf.dart';
import 'product_name_screen.dart';
import 'scanning_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: <Color>[Color(0xff000000), Color(0x004d4d4d)],
                stops: <double>[0, 1],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/backgrnd.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(53, 77, 46, 83.66),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(3, 0, 0, 9),
                        width: double.infinity,
                        height: 78,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 45,
                              height: 49,
                              child: Image.asset(
                                'assets/images/LOGO.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 14),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyShelfScreen(
                                              extractedDate: '',
                                              productName: '',
                                            ),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 56,
                                        height: 59,
                                        child: Image.asset(
                                          'assets/images/shelf.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    width: 236,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 185, 199),
                        child: const Text(
                          'Good Afternoon!',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(45, 0, 28, 17),
                        width: double.infinity,
                        height: 192,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 1,
                              top: 0,
                              child: Align(
                                child: SizedBox(
                                  width: 235,
                                  height: 186.27,
                                  child: Image.asset(
                                    'assets/images/dimsums.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 258,
                                height: 192,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 8, 49),
                        child: const Text(
                          'Let\'s add your first item',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                          width: 65,
                          height: 56.34,
                          child: Image.asset(
                            'assets/images/arrowhome.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 154,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 58,
                        child: Align(
                          child: SizedBox(
                            width: 451,
                            height: 96,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfffff5db),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 154,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 120,
                            height: 115,
                            child: Image.asset(
                              'assets/images/shelf.png',
                              width: 120,
                              height: 115,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 47,
                        top: 74,
                        child: Align(
                          child: SizedBox(
                            width: 30,
                            height: 21,
                            child: Text(
                              'help',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4e4e4e),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 179,
                        top: 24,
                        child: Align(
                          child: SizedBox(
                            width: 72,
                            height: 72,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductNameScreen(
                                      expirationDate: '',
                                      validUpTo: '',
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Image.asset(
                                'assets/images/shelf.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 340,
                        top: 69,
                        child: Align(
                          child: SizedBox(
                            width: 32.83,
                            height: 32.83,
                            child: Image.asset(
                              'assets/images/shelf.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 226, 197, 117),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notifications',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'myShelf.dart';

import 'scanning_screen.dart';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  String getGreeting() {
    final currentTime = DateTime.now();
    if (currentTime.hour < 12) {
      return 'Good Morning!';
    } else if (currentTime.hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: <Color>[Color(0xff000000), Color(0x004d4d4d)],
                stops: <double>[0, 1],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/backgrnd.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(52, 77, 46, 83.66),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                        width: double.infinity,
                        height: 78,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Empty onTap function for logo.png
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                width: 45,
                                height: 49,
                                child: Image.asset(
                                  'assets/images/LOGO.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: double.infinity,
                              width: 212, //dynamic setting needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the MyShelfScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyShelfScreen(
                                            extractedDate: '',
                                            productName: '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 6, 17),
                                      child: Container(
                                        width: 53,
                                        height: 55,
                                        child: Image.asset(
                                          'assets/images/shelf.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        1, 0, 12, 0), //line
                                    width: 230,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 223.4, 180),
                        child: Text(
                          getGreeting(),
                          style: const TextStyle(
                            fontSize: 9.4,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(25, 0, 10, 10),
                        width: 245,
                        height: 195,
                        child: Stack(
                          children: [
                            Positioned(
                              left: -13,
                              top: -20,
                              child: Align(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
                                  width: 215,
                                  height: 186.27,
                                  child: Image.asset(
                                    'assets/images/dimsums.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 258,
                                height: 192,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 0, 8, 39),
                        child: const Text(
                          'Let’s add your first item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: GestureDetector(
                          onTap: () {
                            // Empty onTap function for arrowhome.png
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 14, 0),
                            width: 30,
                            height: 46.34,
                            child: Image.asset(
                              'assets/images/arrowhome.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin:
            const EdgeInsets.only(bottom: 10.0), // Adjust the value as needed
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to the MainScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
          child: const Icon(Icons.qr_code_scanner),
          backgroundColor: Colors.black,
          elevation: 35.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
