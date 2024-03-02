import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/verify_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientLoginScreen extends StatefulWidget {
  @override
  _PatientLoginScreenState createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  TextEditingController phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2ebf0),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),

                const Text(
                  "Sign in/sign up",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: "Enter Mobile Number",
                            prefixIcon:  Icon(
                              Icons.phone,
                              color: Color(0xff117790),
                            ),
                            labelStyle:  TextStyle(
                              color: Color(0xff117790),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        BlocConsumer<AuthCubit,AuthState>(
                          listener: (context, state) {
                            if(state is AuthCodeSentState){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(),));
                            }
                          },
                          builder: ( context, state) {
                            if(state is AuthLoadingState){
                              return const Center(
                                  child:  CircularProgressIndicator()
                              );
                            }
                            return Container(
                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: TextButton(
                                    onPressed: () {
                                  String phoneNumber = "+91" + phoneController.text;
                                  BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                                },
                                    child: const Text('NEXT',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)))
                              );
                          },

                        ),
                        const SizedBox(height: 30),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Login to your corporate account. ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff117790),
                              ),
                            ),
                            const SizedBox(width: 5),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

}


