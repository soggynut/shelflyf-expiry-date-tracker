import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
//import 'package:animated_check/animated_check.dart';
import 'hi.dart';
/*class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
      ),
    );
  }
}*/

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HiPage()),
      );
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Hero(
            tag: 'logoImage',
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/LOGO.png'),
                  scale: 3,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: 145,
            top: 470,
            child: Container(
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.white,
                size: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
