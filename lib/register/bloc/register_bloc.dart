import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<CreateAccount>((event, emit) async {
      if(formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final registData = FirebaseAuth.instance;
        await registData.createUserWithEmailAndPassword(
            email: email,
            password: password,
        ).then((value) {
          emit(RegisterSuccess());
          print(email);
        }).onError((error, stackTrace) {
          emit(RegisterFailed(error.toString()));
        });
      }
    });
  }
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
}
