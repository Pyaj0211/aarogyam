import 'dart:io';

import 'package:aarogyam/patient/views/screens/bottomnavigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AdduserData extends StatefulWidget {
  const AdduserData({super.key});

  @override
  State<AdduserData> createState() => _AdduserDataState();
}

class _AdduserDataState extends State<AdduserData> {
  String _phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String _gmail = '';
  String _address = '';
  Future<void> _getUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('Profile')
            .doc('profileData')
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            _userName = data['username'] ?? '';
            _gmail = data['gmail'] ?? '';
            _address = data['address'] ?? '';
            _phoneNumber = data["mobile"] ?? "";
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching profile data: $e');
        }
      }
    }
  }

    String? newUserName;
    String? newMobile;
    String? newGmail;
    String? newAddress;
    File? image;
    bool isLoading = false;

  @override
  void initState() {
    _getUserProfileData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
       TextEditingController usernameController =
        TextEditingController(text: _userName);
    TextEditingController mobileController =
        TextEditingController(text: _phoneNumber);
    TextEditingController gmailController = TextEditingController(text: _gmail);
    TextEditingController addressController =
        TextEditingController(text: _address);
    return  Scaffold(
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50,),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final file  = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(file != null){
                          image = File(file.path);
                          setState(() {
                            
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        foregroundColor: const Color(0xff117790),
                        foregroundImage: image != null ? FileImage(image!) as ImageProvider : const AssetImage("assets/icons/maki_doctor.png"),
                      ),
                    ),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    onChanged: (value) {
                      newUserName = value;
                    },
                  ),
                  TextField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                      hintText: 'Enter your mobile number',
                    ),
                    onChanged: (value) {
                      newMobile = value;
                    },
                  ),
                  TextField(
                    controller: gmailController,
                    decoration: const InputDecoration(
                      labelText: 'Gmail',
                      hintText: 'Enter your email address',
                    ),
                    onChanged: (value) {
                      newGmail = value;
                    },
                  ),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter your address',
                    ),
                    onChanged: (value) {
                      newAddress = value;
                    },
                  ),
                  const SizedBox(height: 20,),
                isLoading ?  const CircularProgressIndicator() :  ElevatedButton(
                 onPressed: () async {
                  User? user = _auth.currentUser;
                  isLoading = true;
                  setState(() {
                    
                  });
                  if (user != null && image != null) {
                    try {
                      final storageRef = FirebaseStorage.instance.ref().child("user_image").child("${user.uid}.jpg");
                      await storageRef.putFile(image!);
                      final url = await storageRef.getDownloadURL();
                      await _firestore
                          .collection('users')
                          .doc(user.uid)
                          .collection('Profile')
                          .doc('profileData')
                          .set({
                        'username': _userName,
                        'mobile': _phoneNumber.substring(3),
                        'gmail': _gmail,
                        "userImage":url,
                        'address': _address,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BottomNavigationScreen()));
                      _getUserProfileData();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to update profile: $e'),
                      ));
                    }
                  }else{
                    showDialog(context: context, builder: ((context) {
                      return AlertDialog(
                        content: const Text("Please Select image."),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: const Text("Okay"))
                        ],
                      );
                    }));
                  }
                  isLoading = false;
                  setState(() {
                    
                  });
                },
                child: const Text('Save'),
              ),
                ],
              ),
            ),
          ),
    );
  }
}
