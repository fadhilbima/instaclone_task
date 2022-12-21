import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadInitial());
  void uploaded(File file) async {
    final fileName = file.path.split('/').last;
    final fs = FirebaseStorage.instance;
    final imageRef = fs.ref('images/$fileName');
    await imageRef.putFile(file).then((p0) async {
      final url = await p0.ref.getDownloadURL();
      emit(UploadSuccess(url));
    }).onError((error, stackTrace) {
      emit(UploadFailed(error.toString()));
    });
  }
}
