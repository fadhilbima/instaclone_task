part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final int index = 0;
  final String title = 'Home';
  @override
  List<Object> get props => [index, title];
}
class SettingState extends HomeState {
  final int index = 1;
  final String title = 'Setting';
  @override
  List<Object> get props => [index, title];
}
class AddNewPostState extends HomeState {
  @override
  List<Object> get props => [];
}