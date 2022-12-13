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
}