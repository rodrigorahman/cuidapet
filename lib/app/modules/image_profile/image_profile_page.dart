import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'image_profile_controller.dart';

class ImageProfilePage extends StatefulWidget {
  final String title;
  const ImageProfilePage({Key key, this.title = "ImageProfile"})
      : super(key: key);

  @override
  _ImageProfilePageState createState() => _ImageProfilePageState();
}

class _ImageProfilePageState
    extends ModularState<ImageProfilePage, ImageProfileController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
