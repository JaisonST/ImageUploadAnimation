import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_upload_animation/MainUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Click button To Upload"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: SizedBox(), flex: 2),
            Expanded(
                child: CircleAvatar(
                  maxRadius: double.maxFinite,
                ),
                flex: 3),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orangeAccent)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageUpload()));
                      },
                      child: Text(
                        "Upload Pic",
                        style: TextStyle(fontSize: 30),
                      )),
                )),
            Expanded(child: SizedBox(), flex: 4),
          ],
        ),
      ),
    );
  }
}
