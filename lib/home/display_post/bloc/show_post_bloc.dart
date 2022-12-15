import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instaclone/repository/model/model.dart';
import 'package:instaclone/repository/repo/repository.dart';

part 'show_post_event.dart';
part 'show_post_state.dart';

class ShowPostBloc extends Bloc<ShowPostEvent, ShowPostState> {
  ShowPostBloc() : super(ShowPostInitial()) {
    on<GetPost>((event, emit) async {
      emit(ShowPostLoading());
      await postrepo.all().then((models) {
        emit(ShowPostLoaded(models));
      }).onError((error, stackTrace) {
        emit(ShowPostLoaded([]));
      });
    });
  }
  final postrepo = Repository();
}
