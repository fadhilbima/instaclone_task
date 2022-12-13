import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instaclone/routes/model/user_model.dart' as k;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Authenticate>((event, emit) {
      emit(AuthLoading());
      final authData = FirebaseAuth.instance;
      if (authData.currentUser == null) {
        emit(const AuthFailed('User doesnt exist'));
      } else {
        final connect = k.User(
          email: authData.currentUser!.email!,
          password: authData.currentUser!.uid,
        );
        emit(AuthSuccess(connect));
      }
    });

    on<Logout>((event, emit) async {
      emit(AuthLoading());
      final authData = FirebaseAuth.instance;
      await authData.signOut().then((value) {
        emit(AuthLoggedout());
      });
    });
  }
}
