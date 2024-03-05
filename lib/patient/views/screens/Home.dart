import 'package:aarogyam/patient/views/screens/HealthBlog.dart';
import 'package:aarogyam/patient/views/screens/LAbTest.dart';
import 'package:aarogyam/patient/views/screens/Medicine.dart';
import 'package:aarogyam/patient/views/screens/OrderByPrescription.dart';
import 'package:aarogyam/patient/views/screens/ProfileScreen.dart';
import 'package:aarogyam/patient/views/screens/digital_consultant.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserPhoneNumber();
    _getUserProfileData();
  }

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _phoneNumber = user.phoneNumber!;
      });
    }
  }
  String _userName = '';
  String _gmail = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            _phoneNumber = data['mobile'] ?? '';
            _gmail = data['gmail'] ?? '';
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.teal.shade600,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Welcome, $_userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              accountEmail: Text(
                _gmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xff117790),
                  child: _userName.isNotEmpty
                      ? Text(_userName[0].toUpperCase(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
                      : const Icon(Icons.person),
                ),
              ),

              decoration: const BoxDecoration(
                color: Colors.teal,
              ),

            ),
            ListTile(
              leading: const Icon(Icons.person,color: Colors.teal,),
              title: const Text('My Profile',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
              onTap: () {
                // Handle profile tap
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today,color: Colors.teal,),
              title: const Text('Appointments',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
              onTap: () {
                // Handle appointments tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat,color: Colors.teal,),
              title: const Text('Chat with Doctor',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
              onTap: () {
                // Handle chat tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings,color: Colors.teal,),
              title: const Text('Settings',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
              onTap: () {
                // Handle settings tap
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person_pin_rounded, color: Colors.teal),
              title: const Text('About', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w500)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'aarogyam',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 aarogyam',
                  applicationIcon: Image.asset('assets/images/aarogyam.png',width: 50,height: 50,), // Set the application icon
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Welcome to our healthcare app, your one-stop solution for all your medical needs. Our app is designed to make healthcare services more accessible and convenient for you. Whether you need to consult with a doctor, schedule an appointment, or buy medicines, our app has you covered.',
                      ),
                    ),
                  ],
                );
              },
            ),

            // Add some spacing between Settings and Logout
            const Divider(), // Add a divider above the logout option
            ListTile(
              leading: const Icon(Icons.logout,color: Colors.teal,),
              title: const Text('Logout',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w500),),
              onTap: () {
                // Handle logout tap
              },
            ),



          ],
        ),
      ),


        body:
     SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.teal.shade600,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if(scaffoldKey.currentState!.isDrawerOpen){
                                  scaffoldKey.currentState!.closeDrawer();
                                  //close drawer, if drawer is open
                                }else{
                                  scaffoldKey.currentState!.openDrawer();
                                  //open drawer, if drawer is closed
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: const Color(0xff117790),
                                      child: _userName.isNotEmpty
                                          ? Text(_userName[0].toUpperCase(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)
                                          : const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                              ),

                            ),
                             SizedBox(
                              width: size.width* 0.02,
                            ),
                            Text(
                              _userName.isNotEmpty ? _userName : 'Hi Guest !',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: size.width * 0.25,
                            ),
                            const Expanded(
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.yellow,
                              ),
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
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
                                  child: const Icon(Icons.logout,color: Colors.white,size: 20,)
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.teal,
                              ),
                              // border: OutlineInputBorder(),
                              hintText: 'Search for Medicine,Doctor,Lab Tests',
                              hintStyle: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 9),
                child: Card(
                  shadowColor: Colors.green,
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Get.to(const Medicine());
                    },
                    title: const Text(
                      'Express Delivery',
                      style: TextStyle(color: Colors.teal),
                    ),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/images/Medicine.png', width: 28),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Buy Medicine and Essentials',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
                  ),
                ),
              ),
               SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Card(
                  shadowColor: Colors.green,
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Get.to(const Labtest());
                    },
                    title: const Text(
                      'At Home',
                      style: TextStyle(color: Colors.teal),
                    ),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/images/Lab_reports.png', width: 28),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Lab Tests and Packages',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        // margin: EdgeInsets.only(right: 200),
                        shadowColor: Colors.green,
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            Get.to(const DigitalConsult());
                          },
                          leading:
                              Image.asset('assets/images/Doctor.png', width: 35),
                          title: const Text(
                            'Consult',
                            style: TextStyle(
                              fontSize: 13,
                                color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            'Digitaly',
                            style: TextStyle(
                                color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width : MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        // margin: EdgeInsets.only(right: 200),
                        shadowColor: Colors.green,
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          leading:
                          Image.asset('assets/images/Clinic.png', width: 35),
                          title: const Text(
                            'Visit',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            'Hospital',
                            style: TextStyle(
                              fontSize: 13,
                                color: Colors.teal, fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    //borderRadius: BorderRadius.circular(40),
                                    //color: Colors.red
                                    ),
                                height: 60,
                                width: 70,
                                child: Image.asset(
                                  'assets/images/chat 1.png',
                                ),
                              ),
                              const Text(
                                'Ask Us!',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Feeling Unwell? ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Take an assessment in less than 3 min',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'and get suggestion on what to do next',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 9),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 30,
                                      child: Container(
                                        height: 60,
                                        width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.orange.shade100,
                                          ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 25,
                                      child: Image.asset(
                                          'assets/images/medical-report.png',
                                          width: 45),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 35,
                                      child: Text(
                                        'Enter',
                                        style: TextStyle(
                                            color: Colors.orange.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 25,
                                      child: Text(
                                        'Symptoms',
                                        style: TextStyle(
                                            color: Colors.orange.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],

                                  ),
                                ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 30,
                                      child: Container(
                                        height: 60,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blue.shade100,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 25,
                                      child: Image.asset(
                                          'assets/images/symptoms.png',
                                          width: 45),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 20,
                                      child: Text(
                                        'Understand',
                                        style: TextStyle(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 35,
                                      child: Text(
                                        'causes',
                                        style: TextStyle(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],

                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 30,
                                      child: Container(
                                        height: 60,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.greenAccent.shade100,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 25,
                                      child: Image.asset(
                                          'assets/images/Clinic.png',
                                          width: 45),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 35,
                                      child: Text(
                                        'Enter',
                                        style: TextStyle(
                                            color: Colors.green.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60,
                                      left: 25,
                                      child: Text(
                                        'Symptoms',
                                        style: TextStyle(
                                            color: Colors.green.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15,),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.all(15),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'NEXT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              //HEALTH BLOGS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.teal,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/BLOG.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Health Articles & ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'Resources',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                       Column(
                        mainAxisAlignment:  MainAxisAlignment.start,
                        children: [
                          Text(
                            'HEALTH BLOG',
                            style: TextStyle(
                                color: Colors.orange.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          const Text('Explore healthcare content created everyday by'),
                          const Text('oue experts.')
                        ],
                        //Maafi talaafi ki kaafi par aayi kaam nay
                        // jii aap woh leti mera naam nay ,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const HealthBlog());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.orange.shade300,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Read latest articles',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.teal,
            color: Colors.white,
            activeColor: Colors.teal,
            tabBackgroundColor: Colors.grey.shade100,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  // margin: EdgeInsets.only(right: 200),
                  shadowColor: Colors.green,
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      Get.to(const Prescription());
                    },
                    leading: Image.asset('assets/images/medical-report.png',
                        width: 45),
                    title: const Text(
                      'Order via Prescription ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: const Text(
                      '25% OFF',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  // margin: EdgeInsets.only(right: 20),
                  shadowColor: Colors.green,
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/diabetes.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Expanded(
                              child: Text(
                                'Manage Diabetes',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              textDirection: TextDirection.ltr,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.greenAccent.shade100,
                          ),
                          child: const Center(
                            child: Text(
                              'Track, Manage and Improve Your Diabetes',
                              style: TextStyle(
                                  color: Colors.teal, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
