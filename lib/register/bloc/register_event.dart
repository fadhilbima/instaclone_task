part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class CreateAccount extends RegisterEvent {
  @override
  List<Object> get props => [];
}