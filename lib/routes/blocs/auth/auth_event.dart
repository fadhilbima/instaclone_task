part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class Authenticate extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Logout extends AuthEvent {
  @override
  List<Object> get props => [];
}