import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLogOutState) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientLoginScreen(),
                  ));
            }
          },
          builder: (context, state) {
            return TextButton(
                child: const Text('Log Out'),
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                });
          },
        ),
      ),
    );
  }
}
