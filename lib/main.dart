import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
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
  File _image = new File("");
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
                  //TODO:update here
                  backgroundImage:
                      _image.path == "" ? null : Image.file(_image).image,
                  child: _image.path == ""
                      ? SizedBox.fromSize(
                          size: Size.fromRadius(double.maxFinite),
                          child: FittedBox(
                            child: Icon(
                              Icons.account_circle,
                            ),
                          ),
                        )
                      : null,
                ),
                flex: 5),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orangeAccent)),
                      onPressed: () async {
                        await getImage();

                        if (_image.path != '') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageUpload(
                                        newImage: _image,
                                      )));
                        }
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
