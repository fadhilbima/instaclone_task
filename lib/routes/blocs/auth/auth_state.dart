part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}
class AuthSuccess extends AuthState {
  final k.User email;

  AuthSuccess(this.email);
  @override
  List<Object?> get props => [email];
}
class AuthFailed extends AuthState {
  const AuthFailed(this.errorMess);
  final String errorMess;
  @override
  List<Object?> get props => [errorMess];
}

class AuthLoggedout extends AuthState {
  @override
  List<Object> get props => [];
}