import 'package:aarogyam/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingScreen(
        onSkip: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
        },
        showPrevNextButton: true,
        showIndicator: true,
        backgourndColor:const Color(0xffdadfe5),
        activeDotColor: Colors.blue,
        deactiveDotColor: Colors.grey,
        iconColor: Colors.black,
        leftIcon: Icons.arrow_circle_left_rounded,
        rightIcon: Icons.arrow_circle_right_rounded,
        iconSize: 30,
        pages: [
          OnBoardingModel(
            image: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/img/vector/Group1.png"),
            ),
            title: "Welcome to Health Care App",
            body:
            "Your personal health assistant. Manage your health records, appointments, and more.",
          ),
          OnBoardingModel(
            image: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/img/vector/Group2.png"),
            ),
            title: "Track Your Health",
            body:
            "Keep track of your health data, including medications, lab results, and vitals.",
          ),
          OnBoardingModel(
            image: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/img/vector/Group3.jpg"),
            ),
            title: " Medicine Delivery at Your Doorstep",
            body:
            "Get your prescribed medications delivered safely and conveniently to your home. Order online, track your delivery, and ensure you never run out of essential medicines.",
          ),
        ],
      )
      );
  }
}
