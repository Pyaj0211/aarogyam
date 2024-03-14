import 'package:aarogyam/doctor/data/models/session_model.dart';
import 'package:aarogyam/patient/views/screens/video_call_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SessionDetailScreen extends StatelessWidget {
  SessionDetailScreen({super.key, required this.data});
  SessionModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: data.times!.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(data.option ?? ""),
              title: Text(
                  "Meeting time ${DateFormat("hh:mm").format(data.times![index]["slot${index + 1}"][0].toDate())}"),
              trailing: LayoutBuilder(builder: (contex, constais) {
                if (data.times![index]["slot${index + 1}"][1]) {
                  return ElevatedButton(
                    onPressed: () {
                      final uid = FirebaseAuth.instance.currentUser?.uid;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => VideoCallScreen(
                                    uid: data.uid!,
                                    userId: uid!,
                                    userName: "Katva",
                                  )));
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    child: const Text("Start Meeting",style: TextStyle(color: Colors.white),),
                  );
                } else {
                  return TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Not Booked",
                      ));
                }
              }),
            );
          }),
    );
  }
}
