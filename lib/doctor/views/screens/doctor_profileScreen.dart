
// ignore_for_file: camel_case_types, use_build_context_synchronously, non_constant_identifier_names

import 'package:aarogyam/doctor/views/screens/doctor_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Doctor_Profile extends StatefulWidget {
  const Doctor_Profile({super.key});

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
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
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
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
        if (kDebugMode) {
          print('Error fetching profile data: $e');
        }
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                //  border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
                boxShadow:[
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(1,1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : const AssetImage('assets/img/vector/ic_launcher.jpg')
                    as ImageProvider,
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. $name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            specialist,
                            style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text(
                'Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Date of birth", dob),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Email", email),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard("Address", address),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text(
                'Professional Information',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard('Specialist', specialist),
            SizedBox(height: size.height * 0.01),
            _DecoratedCard('General Fee', ' ₹$generalfee'),
            SizedBox(height: size.height * 0.02),

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
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to edit profile screen
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _DecoratedCard(String type, String data) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      //  border: Border.all(width: 2, color: Colors.blue),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        const BoxShadow(
          color: Colors.white,
          offset: Offset(4, 4),
          blurRadius: 15,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(1,1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        Text(data),
        const SizedBox(height: 8),
      ],
    ),
  );
}
