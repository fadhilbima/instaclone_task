import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart' as path;

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? cameraController;
  File? captureImage;
  CameraBloc() : super(CameraInitial()) {
    on<InitCamEvent>((event, emit) async {
      emit(CameraLoading());
      if(cameraController==null) {
        await availableCameras().then((cameras) {
          return cameras.first;
        }).then((rearCam) {
          return CameraController(
            rearCam,
            ResolutionPreset.high,
            enableAudio: false,
          );
        }).then((controller) {
          cameraController = controller;
        }).then((_) async {
          await cameraController!.initialize();
          cameraController!.setFlashMode(FlashMode.off);
        }).whenComplete(() {
          emit(CameraLoaded());
        });
      }
    });
    on<CaptureEvent>((event, emit) async {
      emit(CameraLoading());
      final docFolder = await path.getApplicationDocumentsDirectory();
      final chosenFolder = '${docFolder.path}/Picture';
      Directory(chosenFolder).create(recursive: true);
      await cameraController!.takePicture().then((cameraImageFile) async {
        final timeStamp = DateTime.now().millisecondsSinceEpoch;
        final currentFilePath = cameraImageFile.path;
        final currentFileName = currentFilePath.split('/').last;
        final ext = currentFileName.split('.').last;
        final fileName = '$timeStamp.$ext';
        final file = File('$chosenFolder/$fileName');
        final imageBytes = await cameraImageFile.readAsBytes();
        return await file.writeAsBytes(imageBytes);
      }).then((file) {
        cameraController!.pausePreview();
        captureImage = file;
        emit(CameraSuccess(file));
      });
    });
    on<ClearEvent>((event, emit) {
      emit(CameraLoading());
      cameraController!.resumePreview();
      if (captureImage != null) {
        captureImage!.delete(recursive: true);
      }
      emit(CameraLoaded());
    });
    on<ConfirmEvent>((event, emit) {
      emit(CameraLoading());
      emit(CameraConfirmed(captureImage!));
    });
  }
}