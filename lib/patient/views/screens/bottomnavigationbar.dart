import 'package:aarogyam/patient/views/screens/healthblog.dart';
import 'package:aarogyam/patient/views/screens/labtest.dart';
import 'package:aarogyam/patient/views/screens/digital_consultant.dart';
import 'package:aarogyam/patient/views/screens/ecom/ecom.dart';
import 'package:aarogyam/patient/views/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _index = 0;
  List<Widget> list = <Widget>[
    const HomeScreen(),
    const DigitalConsult(),
    const EcomMedicine(),
    PurchaseDetailsScreen(),
    const HealthBlog(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list.elementAt(_index), // Display the widget based on the selected index
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
              GButton(
                icon: Icons.person_3_sharp,
                text: 'Doctor',
              ),
              GButton(
                icon: Icons.medication_liquid,
                text: 'Medicine',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Buy medicine',
              ),
              GButton(
                icon: Icons.notes,
                text: 'Health Blogs',
              ),
            ],
            selectedIndex: _index, // Set the selected index
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}