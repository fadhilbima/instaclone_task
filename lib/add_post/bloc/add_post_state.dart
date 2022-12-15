part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();
  @override
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostFailed extends AddPostState {
  final String errorMess;
  const AddPostFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess];
}

class AddPostSuccess extends AddPostState {}