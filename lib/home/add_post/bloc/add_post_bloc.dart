import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instaclone/repository/model/model.dart';
import 'package:instaclone/repository/repo/repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SubmitPost>((event, emit) async {
      emit(AddPostLoading());
      final post = Model(
        uid: uidInput.text,
        username: usernameInput.text,
        avatarUrl: avatarUrlInput.text,
        imageUrl: imageUrlInput.text,
        caption: captionInput.text,
      );
      await repoForPost.create(post).then((value) {
        emit(AddPostSuccess());
      }).onError((error, stackTrace) {
        emit(AddPostFailed(error.toString()));
      });
    });
    on<Initialize>((event, emit) {
      final firebaseAuth = FirebaseAuth.instance;
      final user = firebaseAuth.currentUser;
      uidInput.text = user!.uid;
      usernameInput.text = user.email!;
      avatarUrlInput.text = '';
      imageUrlInput.text = '';
      captionInput.text = 'Welcome';
    });
  }

  final uidInput = TextEditingController();
  final usernameInput = TextEditingController();
  final avatarUrlInput = TextEditingController();
  final imageUrlInput = TextEditingController();
  final captionInput = TextEditingController();
  final repoForPost = Repository();
}
