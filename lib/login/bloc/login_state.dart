part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginFailed extends LoginState {
  final String errorMess;
  const LoginFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess];
}
class NoAccount extends LoginState {
  @override
  List<Object> get props => [];
}