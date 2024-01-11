import 'package:aarogyam/patient/views/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';


class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() => _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(),)
      ], child: OtpScreen(),),
    );
  }
}


class OtpScreen extends StatelessWidget {


  OtpScreen({super.key,});

  final  otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(controller: otpController),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {

                if(state is AuthLoggedInState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, CupertinoPageRoute(
                      builder: (context) => const PatientHomeScreen()
                  ));
                }
                else if(state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.error),
                        duration: const Duration(milliseconds: 2000),
                      )
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
                  child: CupertinoButton(
                    onPressed: () {

                      BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);

                    },
                    color: Colors.blue,
                    child: const Text("Verify"),
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
