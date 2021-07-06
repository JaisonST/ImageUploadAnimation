import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_animation/MainUI.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({required this.newImage});
  final File newImage;
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

//TODO: store and collect image from storage
//TODO: upload image to the disk
//TODO: create the image move ability
//TODO: create the uploading animation

class _ImageUploadState extends State<ImageUpload> {
  late File localImage;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        localImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    localImage = widget.newImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFD554B),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Step 1 of 1",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    Text("Profile Picture",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox(), flex: 1),
            Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 9,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: FittedBox(
                                child: Image.file(localImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                          ),
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                  ],
                )),
            Expanded(child: SizedBox(), flex: 1),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff553d83)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        //side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Upload Photo",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Center(
                  //TODO: change to text button
                  child: TextButton(
                    child: Text(
                      "Choose Another?",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await getImage();
                    },
                  ),
                ),
                flex: 2),
          ],
        ),
      ),
    );
  }
}
