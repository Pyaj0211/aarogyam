import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  String _phoneNumber = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String _mobile = '';
  String _gmail = '';
  String _address = '';

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _phoneNumber = user.phoneNumber!;
      });
    }
  }

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
          Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
          setState(() {
            _userName = data['username'] ?? '';
            _mobile = data['mobile'] ?? '';
            _gmail = data['gmail'] ?? '';
            _address = data['address'] ?? '';
          });
        }
      } catch (e) {
        print('Error fetching profile data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserPhoneNumber();
    _getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          _showEditProfileDialog(context);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.teal,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    child: _userName.isNotEmpty
                                        ? Text(_userName[0].toUpperCase())
                                        : Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('UserName :- $_userName'),
                                      Text(
                                        _phoneNumber.isNotEmpty
                                            ? _phoneNumber.substring(3)
                                            : 'Mobile no :- ',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text('Gmail :- $_gmail'),
                                      Text('Address :- $_address'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    TextEditingController usernameController =
    TextEditingController(text: _userName);
    TextEditingController mobileController =
    TextEditingController(text: _phoneNumber.substring(3));
    TextEditingController gmailController = TextEditingController(text: _gmail);
    TextEditingController addressController =
    TextEditingController(text: _address);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color(0xff117790),
                    child: _userName.isNotEmpty
                        ? Text(_userName[0].toUpperCase())
                        : Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _userName = value;
                    });
                  },
                ),
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    hintText: 'Enter your mobile number',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _mobile = value;
                    });
                  },
                ),
                TextField(
                  controller: gmailController,
                  decoration: InputDecoration(
                    labelText: 'Gmail',
                    hintText: 'Enter your email address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _gmail = value;
                    });
                  },
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter your address',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  try {
                    await _firestore
                        .collection('users')
                        .doc(user.uid)
                        .collection('Profile')
                        .doc('profileData')
                        .set({
                      'username': _userName,
                      'mobile': _phoneNumber.substring(3),
                      'gmail': _gmail,
                      'address': _address,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Profile Updated successfully'),
                    ));
                    _getUserProfileData();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to update profile: $e'),
                    ));
                  }
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}