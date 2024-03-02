import 'package:aarogyam/patient/views/screens/HealthBlog.dart';
import 'package:aarogyam/patient/views/screens/LAbTest.dart';
import 'package:aarogyam/patient/views/screens/Medicine.dart';
import 'package:aarogyam/patient/views/screens/OrderByPrescription.dart';
import 'package:aarogyam/patient/views/screens/digital_consultant.dart';
import 'package:aarogyam/patient/views/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../logic/cubit/auth_cubit/auth_cubit.dart';
import '../../logic/cubit/auth_cubit/auth_state.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String _phoneNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserPhoneNumber();
  }

  Future<void> _getUserPhoneNumber() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _phoneNumber = user.phoneNumber!;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade600,
      body:
     SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Container(
                height: 120,
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
                      padding: const EdgeInsets.only(
                          top: 5.0, right: 5.0, left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Icon(Icons.adb_rounded),
                          Image.asset('assets/images/aarogyam.png',
                              width: 40, height: 50),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            _phoneNumber.isNotEmpty ? _phoneNumber.substring(3) : 'Hi Guest !',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 120,
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
                                    builder: (context) => PatientLoginScreen()
                                ));
                              }
                            },
                            builder: (context, state) {
                              return CupertinoButton(
                                onPressed: () {
                                  BlocProvider.of<AuthCubit>(context).logOut();
                                },
                                child: Icon(Icons.logout,color: Colors.white,size: 20,)
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 9),
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.47,
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
                            fontSize: 15,
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
                    width : MediaQuery.of(context).size.width * 0.47,
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
                              fontSize: 15,
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'Hospital',
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
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                    const SizedBox(height: 10),
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
                            const SizedBox(
                              width: 10,
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
                            const SizedBox(width: 10),
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
            const SizedBox(
              height: 20,
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
                    const SizedBox(height: 5),
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
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 10,
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

            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),

    );
  }
}
