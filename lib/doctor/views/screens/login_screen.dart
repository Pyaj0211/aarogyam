import 'package:aarogyam/doctor/views/screens/home_screen.dart';
import 'package:aarogyam/doctor/views/screens/ragistration_screen.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _dusername = TextEditingController();
  final _dpassword = TextEditingController();
  bool isLoading = false;
  bool _obscurePassword = true; // Track the password visibility

  void _login() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _dusername.text, password: _dpassword.text);
        // Login successful, navigate to the home screen or any other screen
        // Replace the below line with your desired navigation logic
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successfully ...! ')));

        // Add a delay of 3 seconds before navigating to the login screen
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return DoctorHomeScreen();
          },
        ));
      } catch (ex) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ex.toString())));
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var screensize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfffdfefd),
      appBar: AppBar(
        backgroundColor: const Color(0xfffdfefd),
        surfaceTintColor: const Color(0xfffdfefd),
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PatientLoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0E5C6E),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/vector/docterlogin.png",
                width: double.infinity,
                height: 320,
              ),
              const Text(
                "your expertise matter on our digital  \n   "
                "                      platform",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff117790)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Docter Login",
                style: TextStyle(
                    color: Color(0xfff89520),
                    fontWeight: FontWeight.w500,
                    fontSize: 35),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _dusername,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              // Use a regular expression to check if the entered email is valid
                              // This is a simple example; you may want to use a more sophisticated regex
                              if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }

                              return null; // Return null if the email is valid
                            },
                            decoration: const InputDecoration(
                                labelText: "Enter Username",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xff117790),
                                ),
                                labelStyle: TextStyle(
                                    color: Color(0xff117790),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ),
                          TextFormField(
                            obscureText: _obscurePassword,
                            controller: _dpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              // Password validation criteria
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }

                              // You can add more validation criteria as needed

                              return null; // Return null if the password is valid
                            },
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xff117790),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff117790),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              labelStyle: const TextStyle(
                                  color: Color(0xff117790),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: _login,
                            child: Container(
                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff89520),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      : const Text(
                                          "Log in",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        )),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have a Account ?",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff117790)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return RegistrationScreen();
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Color(0xfff89520),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
