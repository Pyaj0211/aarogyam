// ignore_for_file: use_build_context_synchronously

import 'package:aarogyam/doctor/logic/bloc/signup_bloc.dart';
import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class DocterRagistrationScreen extends StatefulWidget {
  const DocterRagistrationScreen({super.key});

  @override
  State<DocterRagistrationScreen> createState() =>
      _DocterRagistrationScreenState();
}

class _DocterRagistrationScreenState extends State<DocterRagistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(),
          )
        ],
        child: const RagistrationScreen(),
      ),
    );
  }
}

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({super.key});

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {
  final _dname = TextEditingController();
  final _ddob = TextEditingController();
  final _daddress = TextEditingController();
  final _dspecialist = TextEditingController();
  final _dgernalfeeamount = TextEditingController();
  final _demail = TextEditingController();
  final _dpassword = TextEditingController();
  File? _person;
  File? _certificate;
  String specialist = "Specialist";
  _selecetDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (dt != null) {
      _ddob.text = "${dt.day}/${dt.month}/${dt.year}";
    }
    setState(() {});
  }
  bool isOther = false;
  @override
  void dispose() {
    _dname.dispose();
    _ddob.dispose();
    _daddress.dispose();
    _dspecialist.dispose();
    _dgernalfeeamount.dispose();
    _demail.dispose();
    _dpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfffdfefd),
      appBar: AppBar(
        backgroundColor: const Color(0xfffdfefd),
        surfaceTintColor: const Color(0xfffdfefd),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Doctor Sign in",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                              fontSize: 28),
                        ),
                        SizedBox(height: size.height * 0.02),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 80);

                                setState(() {
                                  _person = File(pickedImage!.path);
                                });
                                BlocProvider.of<SignUpBloc>(context)
                                    .add(SignUpFieldChangeEvent(
                                  name: _dname.text,
                                  dob: _ddob.text,
                                  address: _daddress.text,
                                  email: _demail.text,
                                  password: _dpassword.text,
                                  person: _person,
                                  certificate: _certificate,
                                  specialist: _dspecialist.text,
                                  generalFee: _dgernalfeeamount.text,
                                ));
                              },
                              child: CircleAvatar(
                                radius: size.width * 0.1,
                                backgroundColor: Colors.grey.shade300,
                                foregroundColor: const Color(0xff117790),
                                child: _person == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.file(
                                          _person!,
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: ((context, state) {
                            if (state is SignUpUserPhotoInvalidState) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ),
                        SizedBox(height: size.height * 0.02),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpNameInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _dname,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Enter your name",
                                labelStyle: const TextStyle(
                                    color: Color(0xff117790),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color(0xff117790),
                                ),
                                errorText: error,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpDobInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _ddob,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              onTap: () async {
                                _selecetDate();
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter Date of birth",
                                  prefixIcon: const Icon(
                                    Icons.date_range,
                                    color: Color(0xff117790),
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  errorText: error),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpAddreesInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              controller: _daddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter your Address",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  prefixIcon: const Icon(
                                    Icons.note,
                                    color: Color(0xff117790),
                                  ),
                                  errorText: error),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpSpaicalistInvalidState) {
                              error = state.error;
                            }
                            return Container(
                              height: size.height * 0.08,
                              width: size.width * 0.95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, top: 20),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          color: Color(0xff117790),
                                        ),
                                        Text(
                                          specialist,
                                          style: const TextStyle(
                                              color: Color(0xff117790)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  underline: const SizedBox(),
                                  icon: const SizedBox(),
                                  items:  [
                                    DropdownMenuItem(
                                      value: "neurology",
                                      child: const Text("Neurology"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                    DropdownMenuItem(
                                      value: "bariatrics",
                                      child: const Text("Bariatrics"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                    DropdownMenuItem(
                                      value: "cardiology",
                                      child: const Text("Cardiology"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                     DropdownMenuItem(
                                      value: "dermatology",
                                      child: const Text("Dermatology"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                    DropdownMenuItem(
                                      value: "psychiatry",
                                      child: const Text("Psychiatry"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                    DropdownMenuItem(
                                      value: "paediatrics",
                                      child: const Text("Paediatrics"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                     DropdownMenuItem(
                                      value: "physiotherpy",
                                      child: const Text("Physiotherpy"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                     DropdownMenuItem(
                                      value: "diabetology",
                                      child: const Text("Diabetology"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                     DropdownMenuItem(
                                      value: "urology",
                                      child: const Text("Urology"),
                                      onTap: (){
                                        setState(() {
                                          isOther = false;
                                        });
                                      },
                                    ),
                                    DropdownMenuItem(
                                      value: "other",
                                      child: const Text("Other"),
                                      onTap: (){
                                        setState(() {
                                          isOther = true;
                                        });
                                      },
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      specialist = value!;
                                    });
                                    BlocProvider.of<SignUpBloc>(context).add(
                                        SignUpFieldChangeEvent(
                                            name: _dname.text,
                                            dob: _ddob.text,
                                            address: _daddress.text,
                                            specialist: isOther ? _dspecialist.text : specialist,
                                            generalFee: _dgernalfeeamount.text,
                                            email: _demail.text,
                                            password: _dpassword.text,
                                            person: _person,
                                            certificate: _certificate));
                                  }),
                            );
                          },
                        ),
                        isOther ? BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpGeneralfeeInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _dspecialist,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter your speciality",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xff117790),
                                  ),
                                  errorText: error),
                            );
                          },
                        ) : const SizedBox(),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpGeneralfeeInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _dgernalfeeamount,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter your General fee",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  prefixIcon: const Icon(
                                    Icons.attach_money,
                                    color: Color(0xff117790),
                                  ),
                                  errorText: error),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpEmailInvalidState) {
                              error = state.error;
                            }
                            return TextFormField(
                              controller: _demail,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter your email",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Color(0xff117790),
                                  ),
                                  errorText: error),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            String? error;
                            if (state is SignUpPasswordInvalidState) {
                              error = state.error;
                            }
                            bool visibility = true;
                            if (state is PassVisibilityState) {
                              visibility = state.isOn;
                            }
                            return TextFormField(
                              controller: _dpassword,
                              onChanged: (value) {
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              obscureText: visibility,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter Password",
                                  errorText: error,
                                  prefixIcon: const Icon(
                                    Icons.lock_open,
                                    color: Color(0xff117790),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(visibility
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      visibility
                                          ? BlocProvider.of<SignUpBloc>(context)
                                              .add(PassVisibilityFalseEvent())
                                          : BlocProvider.of<SignUpBloc>(context)
                                              .add(PassVisibilityTrueEvent());
                                    },
                                  ),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff117790),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Add Certificate',
                          style: TextStyle(
                              color: Color(0xff117790),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: size.height * 0.01),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 80);

                                setState(() {
                                  _certificate = File(pickedImage!.path);
                                });
                                BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpFieldChangeEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                        address: _daddress.text,
                                        specialist: _dspecialist.text,
                                        generalFee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate));
                              },
                              child: Container(
                                height: size.height * 0.35,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xff117790), width: 1),
                                ),
                                child: _certificate == null
                                    ? const Icon(
                                        Icons.file_upload_outlined,
                                        size: 30,
                                        color: Color(0xff117790),
                                      )
                                    : Image.file(
                                        _certificate!,
                                        fit: BoxFit.fill,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: ((context, state) {
                            if (state is SignUpUserCertificateInvalidState) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                        ),
                        Container(
                          height: size.height * 0.05,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20)),
                          child: BlocConsumer<SignUpBloc, SignUpState>(
                            listener: (context, state) {
                              if (state is SignUpSubmitState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Ragistration Successfully...!")));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DocterLoginScreen(),
                                    ));
                              } else if (state is ErrorState) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        content: Text(state.error!),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Okay"))
                                        ],
                                      );
                                    });
                              }
                            },
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpFieldChangeEvent(
                                          name: _dname.text,
                                          dob: _ddob.text,
                                          address: _daddress.text,
                                          specialist: isOther ? _dspecialist.text : specialist,
                                          generalFee: _dgernalfeeamount.text,
                                          email: _demail.text,
                                          password: _dpassword.text,
                                          person: _person,
                                          certificate: _certificate));
                                  if (state is SignUpValidState) {
                                    BlocProvider.of<SignUpBloc>(context)
                                        .add(SignUpSubmitEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      specialist: isOther ? _dspecialist.text : specialist,
                                      generalFee: _dgernalfeeamount.text,
                                      address: _daddress.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate,
                                    ));
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('IMPORTANT'),
                                        content: const Text(
                                            'Thank you for signing up! We will notify you as soon as your request is accepted. Please wait patiently until then.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        MaterialStateColor
                                                            .resolveWith(
                                                                (states) =>
                                                                    Colors
                                                                        .teal))),
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) {
                                    if (state is SignUpLoadingState) {
                                      FocusScope.of(context).unfocus();
                                      return const CircularProgressIndicator();
                                    }
                                    return const Center(
                                        child: Text(
                                      "Create Account",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have a Account ?",
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
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(
                                      color: Color(0xfff89520),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
