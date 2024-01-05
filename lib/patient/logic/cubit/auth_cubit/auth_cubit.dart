import 'package:aarogyam/patient/logic/cubit/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(currentUser));
    } else {
      emit(AuthLogOutState());
    }
  }

  void sentOtp(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(
            AuthErrorState(
              error.message.toString(),
            ),
          );
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentState());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
        phoneNumber: phoneNumber);
  }

  void verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLogOutState());
  }
}
