
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/home_screen.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA5KSYy-dfvGietMHrUz07bc8ZAgzJu-3g",
      appId: "1:461917017068:android:852a2ce40636e9b2fd26c9",
      messagingSenderId: '461917017068',
      projectId: 'aarogyam-80aa2',
    ),
  );

  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: MaterialApp(
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) {
            return previous is AuthInitialState;
          },
          builder: (context, state){
            if (state is AuthLoggedInState) {
              return const PatientHomeScreen();
            } else if(state is AuthLogOutState){
              return const PatientLoginScreen();
            }else{
              //splash Screen for future
              return const Scaffold();
            }
          },
        ),
      ),
    ),
  );
}
