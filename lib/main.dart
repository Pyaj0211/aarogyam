import 'package:aarogyam/splashscreen.dart';
import 'package:aarogyam/doctor/views/screens/home_screen.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/BottomNavigationBar.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyA5KSYy-dfvGietMHrUz07bc8ZAgzJu-3g',
        appId: '1:461917017068:android:852a2ce40636e9b2fd26c9',
        messagingSenderId: '461917017068',
        projectId: 'aarogyam-80aa2')
  );
  // Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate();

  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) {
        return previous is AuthInitialState;
      },
      builder: (context, state) {
        return FutureBuilder<Widget?>(
          future: _buildMainWidget(context, state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data ?? const Scaffold(); // Handle null case
            } else {
              return const Scaffold(); // Loading or error state
            }
          },
        );
      },
    );
  }
}


Future<Widget?> _buildMainWidget(BuildContext context, AuthState state) async {
  if (state is AuthLoggedInState) {
    User? user = FirebaseAuth.instance.currentUser;
    var userRoleSnapshot = await FirebaseFirestore.instance.collection('userRole').doc(user?.uid).get();

    if (userRoleSnapshot.exists) {
      var userRole = userRoleSnapshot.data()?['role'];

      if (userRole == 'patient') {
        return const BottomNavigationScreen();
      } else if (userRole == 'doctor') {
        return const DoctorHomeScreen();
      }
    } else {
      //please return that user not found
    }
  } else if (state is AuthLoggedOutState) {
    return  const PatientLoginScreen();
  } else {
    // Splash Screen for future
    return null;
  }
  return null;
}


