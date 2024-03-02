import 'package:aarogyam/main.dart';
import 'package:aarogyam/patient/views/screens/OnbordingScreen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Video/aarogyam.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _controller.addListener(() {
      if (_controller.value.duration == _controller.value.position) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OnbordingScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffeef9fd),
      body: SafeArea(
        child: Center(
          child: _controller.value.isInitialized
              ? Container(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
