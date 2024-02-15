import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:aarogyam/patient/views/screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../logic/cubit/auth_cubit/auth_cubit.dart';


class VerifyPhoneNumberScreen extends StatefulWidget {

  @override
  State<VerifyPhoneNumberScreen> createState() => _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
 // TextEditingController otpController = TextEditingController();
   String?  otpcode;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenForSmsCode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SmsAutoFill().unregisterListener();
  }
   void _listenForSmsCode() async {
     await SmsAutoFill().listenForCode();

     // When a code is detected, populate the Pinput field
     SmsAutoFill().getAppSignature.then((signature) {
       print('App Signature: $signature');
     });

     SmsAutoFill().code.listen((code) {
       setState(() {
         otpcode = code;
       });
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/img/vector/ic_launcher.jpg'),
                    child: null,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the OTP send to your phone number",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.purple.shade200,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpcode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Didn't receive any code?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 20),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if(state is AuthLoggedInState){
                          Navigator.popUntil(context,(route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PatientHomeScreen(),));
                        }
                        else if(state is AuthErrorState){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                              duration: const Duration(milliseconds: 2000),
                              content: Text(state.error))
                          );
                        }
                      },
                      builder: (context, state) {
                        if(state is AuthLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal :15.0),
                            child: CupertinoButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).verifyOTP(otpcode.toString());
                              },
                              color: Colors.blue,
                              child: const Text("Verify"),
                            ),
                          ),
                        );
                      },

                    ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
