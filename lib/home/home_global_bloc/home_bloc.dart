import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/home/display_post/screens/show_post.dart';
import 'package:instaclone/home/settings/logout_button.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) {
      emit(HomeInitial());
      stating[0];
    });
    on<AddPostEvent>((event, emit) {
      emit(AddNewPostState());
      emit(HomeInitial());
    });
    on<SettingEvent>((event, emit) {
      emit(SettingState());
      stating[1];
    });
  }
  final stating = <Widget> [
    ShowPost(),
    LogoutButton(),
  ];
  int index = 0;
}
