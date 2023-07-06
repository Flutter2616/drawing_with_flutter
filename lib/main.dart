import 'package:drawing_with_flutter/screen/drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
        '/':(context) => Drawingscreen(),
        },
      ),
    ),
  );
}
