//bloc event
part of 'signup_bloc.dart';
abstract class SignUpEvent {}

class SignUpFieldChangeEvent extends SignUpEvent {
  SignUpFieldChangeEvent(
      {
        required this.name,
        required this.dob,
        required this.address,
        required this.spicalist,
        required this.generalfee,
        required this.email,
        required this.password,
        required this.person,
        required this.certificate
      });
  String name;
  String dob;
  String address;
  String spicalist;
  String generalfee;
  String email;
  String password;
  File? person;
  File? certificate;
}

class SignUpSubmitEvent extends SignUpEvent {
  SignUpSubmitEvent(
      {
        required this.name,
        required this.dob,
        required this.address,
        required this.spicalist,
        required this.generalfee,
        required this.email,
        required this.password,
        required this.person,
        required this.certificate
      });
  String name;
  String dob;
  String address;
  String spicalist;
  String generalfee;
  String email;
  String password;
  File? person;
  File? certificate;
}

class EmailVerificationEvent extends SignUpEvent {}

class PassVisibilityFalseEvent extends SignUpEvent {}

class PassVisibilityTrueEvent extends SignUpEvent{}