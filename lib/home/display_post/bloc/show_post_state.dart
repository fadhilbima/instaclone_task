part of 'show_post_bloc.dart';

abstract class ShowPostState extends Equatable {
  const ShowPostState();
}

class ShowPostInitial extends ShowPostState {
  @override
  List<Object> get props => [];
}

class ShowPostLoading extends ShowPostState {
  @override
  List<Object> get props => [];

}

class ShowPostLoaded extends ShowPostState {
  final List<Model> models;
  ShowPostLoaded(this.models);
  @override
  List<Object> get props => [models];
}