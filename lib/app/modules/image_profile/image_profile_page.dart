import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'image_profile_controller.dart';

class ImageProfilePage extends StatefulWidget {
  final String title;
  const ImageProfilePage({Key key, this.title = "ImageProfile"}) : super(key: key);

  @override
  _ImageProfilePageState createState() => _ImageProfilePageState();
}

class _ImageProfilePageState extends ModularState<ImageProfilePage, ImageProfileController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.loadCamera();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Aguarde!!!'),  
      ),
    );
  }
}
