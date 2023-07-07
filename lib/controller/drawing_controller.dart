import 'dart:ffi';

import 'package:drawing_with_flutter/screen/drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawingcontroller extends GetxController {
  // var pickcolor = Color(0xff000000).obs;
  RxDouble slider=0.0.obs;
  var currentcolor = Color(0xff000000).obs;
  RxList<Drawingmodal> points = <Drawingmodal>[].obs;
  List<Color> colorlist = [
    Colors.black,
    Colors.amber,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.teal,
    Colors.blue,
    Colors.grey,
    Colors.white,
    Colors.green,
    Colors.indigo,
    Colors.tealAccent,
    Colors.orange,
    Colors.lime
  ];
}
