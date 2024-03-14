import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? uid;
  final String? address;
  final String? certificate;
  final String? dob;
  final String? email;
  final String? genralFee;
  final String? image;
  final String? name;
  final String? password;
  final String? spicailist;
  final String? status;

  DoctorModel({
    this.uid,
    this.address,
    this.certificate,
    this.dob,
    this.email,
    this.genralFee,
    this.image,
    this.name,
    this.password,
    this.spicailist,
    this.status,
  });

  DoctorModel.fromDocumentSnashot(DocumentSnapshot<Map<String, dynamic>?> doc)
      : uid = doc.id,
        address = doc.data()?["address"],
        certificate = doc.data()?["certificate"],
        dob = doc.data()?["dob"],
        email = doc.data()?["email"],
        genralFee = doc.data()?["genralFee"],
        image = doc.data()?["image"],
        name = doc.data()?["name"],
        password = doc.data()?["password"],
        spicailist = doc.data()?["spicailist"],
        status = doc.data()?["status"];

  DoctorModel copyWith({
    String? uid,
    String? address,
    String? certificate,
    String? dob,
    String? email,
    String? genralFee,
    String? image,
    String? name,
    String? password,
    String? spicailist,
    String? status,
  }) =>
      DoctorModel(
        uid: uid ?? this.uid,
        address: address ?? this.address,
        certificate: certificate ?? this.certificate,
        dob: dob ?? this.dob,
        email: email ?? this.email,
        genralFee: genralFee ?? this.genralFee,
        image: image ?? this.image,
        name: name ?? this.name,
        password: password ?? this.password,
        spicailist: spicailist ?? this.spicailist,
        status: status ?? this.status,
      );
}
