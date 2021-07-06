import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
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

class _ImageUploadState extends State<ImageUpload> {
  late File localImage;
  final ImagePicker picker = ImagePicker();
  double x = 0.0;
  double y = 0.0;
  int containerRadius = 30;
  double buttonColorWidth = 0;
  String buttonDisplay = "Upload Photo";

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        localImage = File(pickedFile.path);
      } else {
        print('No image selected.');
        return;
      }
    });
  }

  _updateAnimations() {
    setState(() {
      containerRadius = 160;
      buttonColorWidth = 500;
    });
  }

  @override
  void initState() {
    super.initState();

    localImage = widget.newImage;
    print(localImage.toString());
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
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            child: GestureDetector(
                              onVerticalDragUpdate: (val) {
                                setState(() {
                                  double percentage = val.delta.dy / 100;
                                  double totalShift = percentage * -1;
                                  if (totalShift > 0) {
                                    if (y + totalShift > 1)
                                      y = 1;
                                    else
                                      y = y + totalShift;
                                  } else if (totalShift < 0) {
                                    if (y + totalShift < -1)
                                      y = -1;
                                    else
                                      y = y + totalShift;
                                  }
                                });
                              },
                              onHorizontalDragUpdate: (val) {
                                setState(() {
                                  double percentage = val.delta.dx / 100;
                                  double totalShift = percentage * -1;
                                  if (totalShift > 0) {
                                    if (x + totalShift > 1)
                                      x = 1;
                                    else
                                      x = x + totalShift;
                                  } else if (totalShift < 0) {
                                    if (x + totalShift < -1)
                                      x = -1;
                                    else
                                      x = x + totalShift;
                                  }
                                });
                              },
                              child: AnimatedClipRRect(
                                duration: Duration(seconds: 1),
                                borderRadius: BorderRadius.circular(
                                    containerRadius.toDouble()),
                                child: FittedBox(
                                  child: Image.file(
                                    localImage,
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment(x, y),
                                  clipBehavior: Clip.none,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  containerRadius.toDouble()),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color(0xff553d83),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 3),
                      width: buttonColorWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.greenAccent,
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              //side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () {
                          //todo:crop and store image
                          setState(() {
                            buttonDisplay = "Uploading...";
                          });
                          _updateAnimations();
                        },
                        child: Center(
                          child: Text(buttonDisplay,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Center(
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

//thanks @https://github.com/roughike link: https://github.com/flutter/flutter/issues/43518#issuecomment-681591974
class AnimatedClipRRect extends StatelessWidget {
  const AnimatedClipRRect({
    required this.duration,
    this.curve = Curves.linear,
    required this.borderRadius,
    required this.child,
  });

  final Duration duration;
  final Curve curve;
  final BorderRadius borderRadius;
  final Widget child;

  static Widget _builder(
      BuildContext context, BorderRadius radius, Widget? child) {
    return ClipRRect(borderRadius: radius, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<BorderRadius>(
      duration: duration,
      curve: curve,
      tween: BorderRadiusTween(begin: BorderRadius.zero, end: borderRadius),
      builder: _builder,
      child: child,
    );
  }
}
