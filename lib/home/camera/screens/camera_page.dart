import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/home/camera/bloc/camera_bloc.dart';

class Camera extends StatelessWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(InitCamEvent()),
      child: CameraView(),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<CameraBloc, CameraState>(
            builder: (context, state) {
              print(state);
              if(state is CameraLoading) {
                return const Center(
                  child: Text('Loading Camera..'),
                );
              }
              if(state is CameraSuccess) {
                return Center(
                  child: Image.file(state.image),
                );
              }
              return Builder(builder: (context) {
                if (context.read<CameraBloc>().cameraController==null) {
                  return const Center(
                    child: Text('Read the camera..'),
                  );
                }
                return CameraPreview(
                  context.read<CameraBloc>().cameraController!,
                );
              });
            },
            listener: (context, state) {
              if(state is CameraConfirmed) {
                Navigator.pop(context, state.image);
              }
            },
          ),
          BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if(state is CameraSuccess) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<CameraBloc>().add(ClearEvent());
                          },
                          child: Icon(Icons.clear),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                        ),
                        child: InkWell(
                          onTap: () {
                            context.read<CameraBloc>().add(ConfirmEvent());
                          },
                          child: Icon(Icons.check),
                        ),
                      ),
                    ],
                  )
                );
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                  ),
                  child: InkWell(
                    onTap: () {
                      context.read<CameraBloc>().add(CaptureEvent());
                    },
                    child: Icon(Icons.camera),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
