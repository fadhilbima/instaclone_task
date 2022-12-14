import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();
  bool obscureLogin = true;
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLogin>((event, emit) async {
      if(formKey.currentState!.validate()){
        emit(LoginLoading());
        formKey.currentState!.save();
        final authData = FirebaseAuth.instance;
        await authData.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {
          emit(LoginSuccess());
        }).onError((error, stackTrace) {
          emit(LoginFailed(error.toString()));
        });
      }
    });

    on<NoAccountEvent>((event, emit) async {
      emit(NoAccount());
    });
  }

  bool? showPasswordLogin(bool? v) {
    if(v == obscureLogin || v == !obscureLogin) {
      obscureLogin=obscureLogin==false;
      print(obscureLogin);
    }
    return null;
  }

  String? validateEmailLogin(String? icon) {
    if(icon == null || icon.isEmpty) {
      return 'Email is empty';
    }
  }

  String? validatePasswordLogin(String? icon) {
    if(icon == null || icon.isEmpty) {
      return 'Blank password';
    }
    if(icon.length < 8) {
      return 'Password must be 8 character';
    }
  }
}