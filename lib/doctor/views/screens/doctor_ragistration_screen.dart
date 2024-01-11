import 'package:aarogyam/doctor/logic/bloc/signup_bloc.dart';
import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class DocterRagistrationScreen extends StatefulWidget {
  const DocterRagistrationScreen({Key? key}) : super(key: key);

  @override
  State<DocterRagistrationScreen> createState() => _DocterRagistrationScreenState();
}

class _DocterRagistrationScreenState extends State<DocterRagistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(),)
        ], child: const RagistrationScreen(),
      ),
    );
  }
}

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({Key? key}) : super(key: key);

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {

  final _dname = TextEditingController();
  final _ddob = TextEditingController();
  final _daddress = TextEditingController();
  final _dSpecialist = TextEditingController();
  final _dgernalfeeamount = TextEditingController();
  final _demail = TextEditingController();
  final _dpassword = TextEditingController();
  File? _person;
  File? _certificate;

  _selecetDate() async {
    DateTime? dt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(3000),
    );
    if (dt != null) {
      _ddob.text = dt.day.toString() +
          "/" +
          dt.month.toString() +
          "/" +
          dt.year.toString();
    }
    setState((){
    });
  }

  @override
  void dispose() {
    _dname.dispose();
    _ddob.dispose();
    _daddress.dispose();
    _dSpecialist.dispose();
    _dgernalfeeamount.dispose();
    _demail.dispose();
    _dpassword.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfefd),
      appBar: AppBar(
        backgroundColor: const Color(0xfffdfefd),
        surfaceTintColor:  const Color(0xfffdfefd),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Docter Sign in",style: TextStyle(color: Color(0xfff89520),fontWeight: FontWeight.w500,fontSize: 35),),
                      const SizedBox(height: 20,),
                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder:  (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              final pickedImage = await ImagePicker()
                                  .pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 80);

                              setState(() {
                                _person = File(pickedImage!.path);
                              });
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            child: CircleAvatar(
                              radius: 40,
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
                          if(state is SignUpUserPhotoInvalidState){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }else{
                            return const SizedBox();
                          }
                        }),
                      ),

                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpNameInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            controller: _dname,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            decoration:  InputDecoration(
                              labelText: "Enter your name",
                              labelStyle: const TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                              prefixIcon: const Icon(Icons.person,color: Color(0xff117790),),
                              errorText: error,
                            ),
                          );

                        },),


                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpDobInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            controller: _ddob,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            onTap: () async {
                              _selecetDate();
                            },
                            decoration:  InputDecoration(
                                labelText: "Enter Date of birth",
                                prefixIcon: const Icon(Icons.date_range,color: Color(0xff117790),),
                                labelStyle: const TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                errorText: error
                            ),
                          );

                        },),


                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpAddreesInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            controller: _daddress,
                            decoration:  InputDecoration(
                                labelText: "Enter your Address",
                                labelStyle: const TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                prefixIcon: const Icon(Icons.note,color: Color(0xff117790),),
                                errorText: error
                            ),
                          );

                        },),

                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpSpaicalistInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            controller: _dSpecialist,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            decoration:  InputDecoration(
                                labelText: "Enter your Spicailist",
                                labelStyle: const TextStyle(color:  Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                prefixIcon: const Icon(Icons.stars_rounded,color: Color(0xff117790),),
                                errorText: error
                            ),
                          );

                        },),

                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpGeneralfeeInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            controller: _dgernalfeeamount,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            decoration:  InputDecoration(
                                labelText: "Enter your Genralfee",
                                labelStyle: const  TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                prefixIcon: const Icon(Icons.attach_money,color: Color(0xff117790),),
                                errorText: error
                            ),
                          );

                        },),

                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpEmailInvalidState){
                            error = state.error;
                          }
                          return  TextFormField(
                            controller: _demail,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            decoration:  InputDecoration(
                                labelText: "Enter your email",
                                labelStyle: const TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                prefixIcon: const Icon(Icons.email_outlined,color: Color(0xff117790),),
                                errorText: error
                            ),
                          );

                        },),

                      BlocBuilder<SignUpBloc,SignUpState>(
                        builder: (context, state) {
                          String? error;
                          if(state is SignUpPasswordInvalidState){
                            error = state.error;
                          }
                          bool visibility = true;
                          if (state is PassVisibilityState) {
                            visibility = state.isOn;
                          }
                          return  TextFormField(
                            controller: _dpassword,
                            onChanged: (value){
                              BlocProvider.of<SignUpBloc>(context).add(
                                  SignUpFieldChangeEvent(
                                      name: _dname.text,
                                      dob: _ddob.text,
                                      address: _daddress.text,
                                      spicalist: _dSpecialist.text,
                                      generalfee: _dgernalfeeamount.text,
                                      email: _demail.text,
                                      password: _dpassword.text,
                                      person: _person,
                                      certificate: _certificate
                                  )
                              );
                            },
                            obscureText: visibility,
                            decoration: InputDecoration(
                                labelText: "Enter Password",
                                errorText: error,
                                prefixIcon: const  Icon(Icons.lock_open,color: Color(0xff117790),),
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
                                labelStyle: const TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                            ),
                          );

                        },),

                      const SizedBox(height: 10,),
                      const Text('Add Certificate',style: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),
                      BlocBuilder<SignUpBloc,SignUpState>(
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
                                        spicalist: _dSpecialist.text,
                                        generalfee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate
                                    )
                                );
                            },
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xff117790),
                                    width: 1
                                ),
                              ),
                              child: _certificate == null
                                  ? const Icon(Icons.file_upload_outlined,size: 30,color: Color(0xff117790),)
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


                      const SizedBox(height: 10,),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: ((context, state) {
                          if(state is SignUpUserCertificateInvalidState){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }else{
                            return const SizedBox();
                          }
                        }),
                      ),


                      Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            color: const Color(0xfff89520),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: BlocConsumer<SignUpBloc, SignUpState>(
                          listener: (context, state) {
                            if(state is SignUpSubmitState){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ragistration Successfully...!")));
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DocterLoginScreen(),));
                            }else if (state is ErrorState) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Text(
                                          state.error!),
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
                                        spicalist: _dSpecialist.text,
                                        generalfee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate
                                    )
                                );
                                if (state is SignUpValidState) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpSubmitEvent(
                                        name: _dname.text,
                                        dob: _ddob.text,
                                          spicalist: _dSpecialist.text,
                                        address: _daddress.text,
                                        generalfee: _dgernalfeeamount.text,
                                        email: _demail.text,
                                        password: _dpassword.text,
                                        person: _person,
                                        certificate: _certificate,
                                      ));
                                }
                              },
                              child: BlocBuilder<SignUpBloc, SignUpState>(
                                builder: (context, state) {
                                  if(state is SignUpLoadingState){
                                    FocusScope.of(context).unfocus();
                                    return const CircularProgressIndicator();
                                  }
                                  return const Center(
                                      child:  Text("Sign in ",
                                        style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have a Account ?",style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff117790)),),
                          const SizedBox(width: 5,),
                          GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                },));

                              },
                              child: const Text('Log in',style: TextStyle(color: Color(0xfff89520),fontWeight: FontWeight.bold,fontSize: 17),)
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

