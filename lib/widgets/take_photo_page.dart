import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController controller;

  XFile? takenPhoto;

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);

      controller =
          CameraController((await availableCameras())[0], ResolutionPreset.max);
      try {
        await controller.initialize();
        if (mounted) {
          setState(() {});
        }
      } on CameraException catch (e) {
        switch (e.code) {
          case "CameraAccessDenied":
            // Handle access errors here
            break;
          default:
            // Handle other errors here
            break;
        }
      }
    }();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: takenPhoto != null
          ? Center(
              child: Image.file(File(takenPhoto!.path)),
            )
          : Center(
              child: CameraPreview(controller),
            ),
      floatingActionButton: takenPhoto != null
          ? FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(takenPhoto);
              },
            )
          : FloatingActionButton(
              child: const Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  if (controller == null || !controller.value.isInitialized) {
                    return;
                  }
                  XFile file = await controller.takePicture();
                  setState(() {
                    takenPhoto = file;
                  });

                  print("file.path: ${file.path}");
                } catch (e) {
                  print("error: $e");
                }
              },
            ),
    );
  }
}
