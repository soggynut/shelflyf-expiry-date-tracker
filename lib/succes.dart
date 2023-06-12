import 'package:flutter/material.dart';
//import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'myShelf.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:animated_check/animated_check.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  FlutterTts flutterTts = FlutterTts();
  bool _isSoundPlayed = false;
  String _message = 'Scan successful';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCirc,
    ));
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed && !_isSoundPlayed) {
        // Animation is complete, play the sound effect
        await _playSound();

        // Set the flag to avoid replaying the sound effect
        _isSoundPlayed = true;
      }
      if (status == AnimationStatus.completed) {
        // Animation is complete, navigate to MyShelfScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyShelfScreen(extractedDate: '', productName: '')),
        );
      }
    });
    _animationController.forward();

    // Play the sound effect when the screen initializes
    _playSound();
  }

  @override
  void dispose() {
    _animationController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _playSound() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.speak(_message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: AnimatedCheck(
                progress: _animation,
                size: 200,
                color: const Color.fromARGB(255, 76, 175, 116),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
