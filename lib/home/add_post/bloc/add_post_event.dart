part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();
  @override
  List<Object> get props => [];
}

class SubmitPost extends AddPostEvent {}

class Initialize extends AddPostEvent {}