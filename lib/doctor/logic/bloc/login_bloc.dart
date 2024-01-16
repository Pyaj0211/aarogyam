import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginFieldChangedEvent>((event, emit) {
      if (event.email!.isEmpty ||
          event.email?.trim() == null ||
          !event.email!.contains('@')) {
        emit(LoginEmailInvalidState(error: 'Enter valid email'));
      } else if (event.password!.isEmpty || event.password!.length < 8) {
        emit(LoginPasswordInvalidState(
            error: 'Password must be 8 character long'));
      } else {
        emit(LoginValidState());
      }
    });

    on<PassVisibilityFalseEvent>(
          (event, emit) {
        emit(PassVisibilityState(isOn: false));
      },
    );

    on<PassVisibilityTrueEvent>(
          (event, emit) {
        emit(PassVisibilityState(isOn: true));
      },
    );


    on<LoginSubmitEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email!, password: event.password!);
        emit(LoginSubmitState());
      } on FirebaseAuthException catch (error) {
        emit(ErrorState(error: error.message!));
      }
    });
  }
}
