import 'dart:async';
import 'dart:io';
import 'package:aarogyam/doctor/views/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RagistrationScreen extends StatefulWidget {
  const RagistrationScreen({Key? key}) : super(key: key);

  @override
  State<RagistrationScreen> createState() => _RagistrationScreenState();
}

class _RagistrationScreenState extends State<RagistrationScreen> {

  File? _selectImage;
  File? _certificate;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  final _dname = TextEditingController();
  final _ddob = TextEditingController();
  final _daddress = TextEditingController();
  final _dSpecialist = TextEditingController();
  final _dgernalfeeamount = TextEditingController();
  final _demail = TextEditingController();
  final _dpassword = TextEditingController();
  bool _obscurePassword = true;

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

  void _registerdocter () async {
    if(_formkey.currentState!.validate() && _selectImage != null ){
      setState(() {
        isLoading = true;
      });
      try{
        //docter profile
        final _firebaseStorage = FirebaseStorage.instance
            .ref()
            .child('docter')
            .child('${_selectImage!.path}');
        await _firebaseStorage.putFile(_selectImage!);
        final _imageurl = await _firebaseStorage.getDownloadURL();

        //docter certificate
          final _additionalImageStorage = FirebaseStorage.instance
              .ref()
              .child('docter')
              .child('${_certificate!.path}');
          await _additionalImageStorage.putFile(_certificate!);
          final _certificateUrl = await _additionalImageStorage.getDownloadURL();


        // Create user account with email and password
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _demail.text,
          password: _dpassword.text,
        );

        // Get the user ID (UID) from the userCredential
        String userId = userCredential.user!.uid;

        FirebaseFirestore.instance.collection('Request').doc(userId).set({
          'name': _dname.text,
          'age': _ddob.text,
          'address': _daddress.text,
          'specialist': _dSpecialist.text,
          'general_fee': _dgernalfeeamount.text,
          'email': _demail.text,
          'password': _dpassword.text,
          'status' :'Pending',
          'image':_imageurl,
          'certificate': _certificateUrl,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Ragistration succesfully...! ')));

        // Add a delay of 3 seconds before navigating to the login screen
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
        _dname.clear();
         _ddob.clear();
         _daddress.clear();
         _dSpecialist.clear();
         _dgernalfeeamount.clear();
         _demail.clear();
         _dpassword.clear();
        setState(() {
          _selectImage = null;
          _certificate = null;
        });
      }catch(ex){
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(ex.toString())));
      }
      setState(() {
        isLoading = false;
      });
    }else{
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: _selectImage == null && _certificate == null
              ? const Text('Choose Image')
              : const Text('Failes to insert')));
    }

  }

  _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 80);
    if (image == null) {
      return;
    }
    setState(() {
      _selectImage = File(image.path);
    });
  }
  _pickCertificate() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
    if (image == null) {
      return;
    }
    setState(() {
      _certificate  = File(image.path);
    });
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
                const SizedBox(height: 30,),

                const Text("Docter Sign in",style: TextStyle(color: Color(0xfff89520),fontWeight: FontWeight.w500,fontSize: 35),),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: const Color(0xff117790),
                    child: _selectImage == null
                        ? const Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          )
                        : ClipOval(
                          child: Image.file(
                              _selectImage!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,

                            ),
                        ),
                  ),
                ),
                const SizedBox(height: 10,),
                Form(
                    key: _formkey,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:30,right: 30),
                        child: Column(
                          children: [

                            TextFormField(
                              controller: _dname,
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'Please Enter your name' ;
                                }
                                return null;

                              },
                              decoration: const InputDecoration(
                                  labelText: "Enter your name",
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),
                                prefixIcon: Icon(Icons.person,color: Color(0xff117790),),
                              ),
                            ),
                            TextFormField(
                              controller: _ddob,
                              onTap: () async {
                                _selecetDate();
                              },
                              validator: (value) {
                                if( value == null  || value.isEmpty){
                                  return 'Please Enter Date of birth ' ;
                                }
                                return null;

                              },
                              decoration: const InputDecoration(
                                  labelText: "Enter Date of birth",
                                  prefixIcon: Icon(Icons.date_range,color: Color(0xff117790),),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),
                            TextFormField(
                              controller: _daddress,
                              validator: (value) {
                                if( value == null  || value.isEmpty){
                                  return 'Please Enter Address ' ;
                                }
                                return null;

                              },
                              decoration: const InputDecoration(
                                  labelText: "Enter Address ",
                                  prefixIcon: Icon(Icons.note,color: Color(0xff117790),),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),
                            TextFormField(
                              controller: _dSpecialist,
                              validator: (value) {
                                if( value == null  || value.isEmpty){
                                  return 'Please Enter your Specialist' ;
                                }
                                return null;

                              },

                              decoration: const InputDecoration(
                                  labelText: "Enter your Specialist",
                                  prefixIcon: Icon(Icons.stars_rounded  ,color: Color(0xff117790),),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),
                            TextFormField(
                              controller: _dgernalfeeamount,
                              validator: (value) {
                                if( value == null  || value.isEmpty){
                                  return 'Please Enter your Genral fee amount' ;
                                }
                                return null;

                              },
                              decoration: const InputDecoration(
                                  labelText: "Enter your Genral fee Amount  ",
                                  prefixIcon: Icon(Icons.attach_money,color: Color(0xff117790),),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),
                            TextFormField(
                              controller: _demail,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                // Use a regular expression to check if the entered email is valid
                                // This is a simple example; you may want to use a more sophisticated regex
                                if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }

                                return null; // Return null if the email is valid
                              },
                              decoration: const InputDecoration(
                                  labelText: "Enter Email",
                                  prefixIcon: Icon(Icons.email_outlined,color: Color(0xff117790),),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),

                            TextFormField(
                              controller: _dpassword,
                              obscureText: _obscurePassword,
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
                                  prefixIcon: Icon(Icons.lock_open,color: Color(0xff117790),),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                      color: Color(0xff117790),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword ;
                                      });
                                    },
                                  ),
                                  labelStyle: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500)
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text('Add Certificate',style: TextStyle(color: Color(0xff117790),fontSize: 17,fontWeight: FontWeight.w500),),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: _pickCertificate ,
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff117790),
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
                            ),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: _registerdocter,
                              child: Container(
                                height: 50,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: const Color(0xfff89520),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: isLoading ? const CircularProgressIndicator(color:Colors.black,) : const Text("Sign in ",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)),
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
                                        return LoginScreen();
                                      },));

                                    },
                                    child: const Text('Log in',style: TextStyle(color: Color(0xfff89520),fontWeight: FontWeight.bold,fontSize: 17),)
                                )
                              ],
                            )
                          ],

                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
