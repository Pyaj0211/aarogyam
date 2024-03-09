import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({Key? key}) : super(key: key);

  @override
  _PatientLoginScreenState createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/aarogyam.png'),
                    child: null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sign in/sign up",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Enter Mobile Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xff117790),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff117790),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthCodeSentState) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(),));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              String phoneNumber = "+91${phoneController.text}";
                              BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                            },
                            child: const Text('NEXT',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login to your corporate account. ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff117790),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DocterLoginScreen(),));
                        },
                        child: const Text(
                          'Login Here',
                          style: TextStyle(
                            color: Color(0xfff89520),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
