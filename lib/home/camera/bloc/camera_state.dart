part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();
}

class CameraInitial extends CameraState {
  @override
  List<Object> get props => [];
}
class CameraLoading extends CameraState {
  @override
  List<Object> get props => [];
}
class CameraLoaded extends CameraState {
  @override
  List<Object> get props => [];
}
class CameraSuccess extends CameraState {
  final File image;

  const CameraSuccess(this.image);
  @override
  List<Object> get props => [image];
}
class CameraFailed extends CameraState {
  final String errorMess;
  const CameraFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess];
}
class CameraConfirmed extends CameraState {
  final File image;
  const CameraConfirmed(this.image);
  @override
  List<Object> get props => [image];
}