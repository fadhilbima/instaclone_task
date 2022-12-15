part of 'show_post_bloc.dart';

abstract class ShowPostEvent extends Equatable {
  const ShowPostEvent();
}

class GetPost extends ShowPostEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPost extends ShowPostEvent {
  @override
  List<Object?> get props => [];
}