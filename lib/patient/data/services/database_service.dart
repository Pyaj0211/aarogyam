import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/patient/data/models/videocalling_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  addMeeting(VideoCallingModel videoCallingModel) async {
    await _db.collection("Meetings").doc(uid).collection("Meeting").doc().set({
      "userId": videoCallingModel.userId,
      "callId": videoCallingModel.callId,
      "meetingTime": videoCallingModel.meetingTime
    });
  }

  Future<List<VideoCallingModel>> getAllMeeting() async {
    final snapshot =
        await _db.collection("Meeting").doc(uid).collection("Meeting").get();
    return snapshot.docs
        .map((e) => VideoCallingModel.fromDocumentSnashot(e))
        .toList();
  }

  Future<VideoCallingModel> getMeeting(
      VideoCallingModel videoCallingModel) async {
    final snapshot = await _db
        .collection("Meetings")
        .doc(uid)
        .collection("Meeting")
        .doc(videoCallingModel.uid)
        .get();
    return VideoCallingModel.fromDocumentSnashot(snapshot);
  }

  Future<List<DoctorModel>> getAllDoctor() async {
    final snapshot = await _db.collection("request").get();
    return snapshot.docs
        .map((e) => DoctorModel.fromDocumentSnashot(e))
        .toList();
  }
}
