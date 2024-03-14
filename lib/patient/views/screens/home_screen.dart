import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';

class PatientHomeScreen1 extends StatelessWidget {
  const PatientHomeScreen1({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: Center(
        
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
        
              if(state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, CupertinoPageRoute(
                    builder: (context) => const PatientLoginScreen()
                ));
              }
        
            },
            builder: (context, state) {
              return CupertinoButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                },
                child: const Text("Log Out"),
              );
            },
          ),
        
        ),
      ),
    );
  }
}