import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
            SizedBox(height: 24,),
            Text(picture.name)
          ],
        ),
      ),
    );
  }
}
