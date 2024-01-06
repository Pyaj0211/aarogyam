import 'package:aarogyam/patient/views/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../doctor/views/screens/login_screen.dart';
import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';

class PatientLoginScreen extends StatelessWidget {
  const PatientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController mobileNumberController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Set a fixed height for the container
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: mobileNumberController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Enter Mobile Number',
                        style: TextStyle(color: Colors.blue),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthCodeSentState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                            mobileNumber: mobileNumberController.text),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        String phoneNumber =
                            "+91${mobileNumberController.text}";
                        BlocProvider.of<AuthCubit>(context)
                            .sentOtp(phoneNumber);
                      },
                      child: const Text('Next'),
                    ),
                  );
                },
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "For Doctor Sign In ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff117790),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DoctorLoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'click here',
                        style: TextStyle(
                          color: Color(0xfff89520),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
