import 'package:flutter/material.dart';

class ErrorsPage extends StatefulWidget {
  final String title;
  const ErrorsPage({Key key, this.title = "Errors"}) : super(key: key);

  @override
  _ErrorsPageState createState() => _ErrorsPageState();
}

class _ErrorsPageState extends State<ErrorsPage> {
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
