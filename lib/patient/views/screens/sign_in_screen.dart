import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:aarogyam/patient/views/screens/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';


class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({Key? key}) : super(key: key);

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(),)

      ], child:  LoginScreenPatient(),),
    );
  }
}

class LoginScreenPatient extends StatelessWidget {
   LoginScreenPatient({Key? key}) : super(key: key);

  final mobileNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Set a fixed height for the container
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
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

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {

                  if(state is AuthCodeSentState) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const VerifyPhoneNumberScreen();
                    },));
                  }

                },
                builder: (context, state) {

                  if(state is AuthLoadingState) {
                    return const Center(
                      child: const CircularProgressIndicator(),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () {
                        String phoneNumber = "+91${mobileNumberController.text}";
                        BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                      },
                      color: Colors.blue,
                      child: const Text("Sign In"),
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
                              return const DocterLoginScreen();
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

