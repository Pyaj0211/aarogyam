import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Doctor_Profile extends StatefulWidget {
  const Doctor_Profile({Key? key}) : super(key: key);

  @override
  State<Doctor_Profile> createState() => _Doctor_ProfileState();
}

class _Doctor_ProfileState extends State<Doctor_Profile> {

  String name = '';
  String email = '';
  String generalfee = '';
  String dob = '';
  String address = '';
  String specialist = '';
  String? imageUrl; // Store user's profile image URL

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getUserProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot snapshot = await _firestore
            .collection('request')
            .doc(user.uid) // Fetch document based on user's UID
            .get();

        if (snapshot.exists) {
          Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'] ?? '';
            specialist = data['spicailist'] ?? '';
            email = data['email'] ?? '';
            address = data['address'] ?? '';
            dob = data['dob'] ?? '';
            generalfee = data['genralFee'] ?? '';
            imageUrl = data['image']; // Get user's profile image URL
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
    _getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : AssetImage('assets/img/vector/ic_launcher.jpg') as ImageProvider,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. $name',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$specialist',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text('Date of Birth: $dob'),
                    Text('Email: $email'),
                    Text('Address: $address'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Professional Information',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text('Specialist: $specialist'),
                    Text('General Fee: $generalfee'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DocterLoginScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Log Out'),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to edit profile screen
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
