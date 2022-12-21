part of 'upload_bloc.dart';

abstract class UploadState extends Equatable {
  const UploadState();
}

class UploadInitial extends UploadState {
  @override
  List<Object> get props => [];
}
class UploadLoading extends UploadState {
  @override
  List<Object> get props => [];
}
class UploadSuccess extends UploadState {
  final String fileUrl;
  UploadSuccess(this.fileUrl);
  @override
  List<Object> get props => [fileUrl];
}
class UploadFailed extends UploadState {
  final String errorMess;

  UploadFailed(this.errorMess);
  @override
  List<Object> get props => [errorMess];
}
