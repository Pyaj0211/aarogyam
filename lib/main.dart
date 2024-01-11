import 'package:aarogyam/app_routing.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyA5KSYy-dfvGietMHrUz07bc8ZAgzJu-3g',
        appId: '1:461917017068:android:852a2ce40636e9b2fd26c9',
        messagingSenderId: '461917017068',
        projectId: 'aarogyam-80aa2')
  );
  // Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouting = AppRouting();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PatientLoginScreen(),
      onGenerateRoute: appRouting.onGenerateRoute,
    );
  }
}

