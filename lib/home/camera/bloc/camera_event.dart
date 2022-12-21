part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class CaptureEvent extends CameraEvent {
  @override
  List<Object?> get props => [];
}
class InitCamEvent extends CameraEvent {
  @override
  List<Object?> get props => [];
}
class ClearEvent extends CameraEvent {
  @override
  List<Object?> get props => [];
}
class ConfirmEvent extends CameraEvent {
  @override
  List<Object?> get props => [];
}