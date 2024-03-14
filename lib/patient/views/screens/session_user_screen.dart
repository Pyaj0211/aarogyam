import 'dart:developer';

import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/patient/logic/bloc/digital_bloc.dart';
import 'package:aarogyam/patient/views/screens/video_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SessionUserDetailScreen extends StatelessWidget {
  SessionUserDetailScreen(
      {super.key, required this.data, required this.doctorModel});
  SessionModel data;
  DoctorModel doctorModel;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book slots here"),
      ),
      body: ListView.builder(
          itemCount: data.times!.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(data.option ?? ""),
              title: Text(
                  "Meeting time ${DateFormat("hh:mm a").format(data.times![index]["slot${index + 1}"][0].toDate())}"),
              trailing: LayoutBuilder(builder: (contex, constais) {
                if (data.times![index]["slot${index + 1}"][1]) {
                  if (data.times![index]["slot${index + 1}"][2] == uid) {
                    return ElevatedButton(
                      onPressed: () {
                        if (DateTime.now().isAfter(data.times![index]
                                ["slot${index + 1}"][0]
                            .toDate())) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoCallScreen(
                                uid: data.uid!,
                                userId: uid!,
                                userName: "Jaydeep",
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (contex) => AlertDialog(
                              content: const Text(
                                  "Meeting time not start or you may missed meeting"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Okay"))
                              ],
                            ),
                          );
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      child: const Text(
                        "Start Meeting",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return TextButton(
                        onPressed: () {}, child: const Text("Booked"));
                  }
                } else {
                  return TextButton(
                      onPressed: () {
                        data.times![index] = {
                          "slot${index + 1}": [
                            data.times![index]["slot${index + 1}"][0],
                            true,
                            uid
                          ]
                        };
                        BlocProvider.of<DigitalBloc>(context).add(BookSlot(
                            docId: doctorModel.uid!,
                            uid: data.uid!,
                            list: data.times!));
                      },
                      child: const Text(
                        "Book Now",
                      ));
                }
              }),
            );
          }),
    );
  }
}
