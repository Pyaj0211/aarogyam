import 'package:aarogyam/patient/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';

class OtpScreen extends StatelessWidget {
  String mobileNumber;

  OtpScreen({super.key, required this.mobileNumber});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(controller: otpController),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedInState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatientHomeScreen(),
                    ),
                  );
                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return (const Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOtp(otpController.text);
                    },
                    child: const Text('Next'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
