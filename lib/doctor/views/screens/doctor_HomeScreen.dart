import 'package:aarogyam/doctor/views/screens/doctor_profileScreen.dart';
import 'package:flutter/material.dart';

import 'addAppointment.dart';

class Doctor_HomePage extends StatefulWidget {
  const Doctor_HomePage({Key? key}) : super(key: key);

  @override
  State<Doctor_HomePage> createState() => _Doctor_HomePageState();
}

class _Doctor_HomePageState extends State<Doctor_HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            toolbarHeight: 15,
            backgroundColor: Colors.grey.shade100,
          //  title: const Text('Doctor Panel'),
            bottom: const TabBar(
              //isScrollable: true,
                labelColor: Colors.teal,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: 'Add Session',icon: Icon(Icons.add_circle),
                  ),
                  Tab(text: 'View Session',icon: Icon(Icons.add_chart),),
                  Tab(text: 'Profile',icon: Icon(Icons.person),),
                ]),
          ),
          body: TabBarView(
            children: [
              AddAppointmentSlots(),
              Container(color: Colors.teal,),
              Doctor_Profile(),
            ],
          ),
        ));
  }
}
