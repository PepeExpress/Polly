import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_classification/controllers/quiz_screen_controller.dart';
import 'package:plant_classification/screens/quiz_screen.dart';
import 'package:plant_classification/widgets/gradient_background.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        MultipleGradientBG(),
        Center(
          child: _image == null ? null : Image.file(_image!),
        ),
      ]),
      backgroundColor: Colors.transparent,
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    QuizScreenController c = Get.find();
    c.originalImage = pickedFile!.path;
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 224,
          maxWidth: 224,
          compressFormat: ImageCompressFormat.jpg);
      setState(() {
        if (croppedFile != null) {
          _image = File(croppedFile.path);
        } else {
          print("No image selected.");
        }
        c.croppedImagePath = croppedFile!.path;
        Navigator.pushNamed(
          context,
          '/quiz',
        );
      });
    }
  }
}
