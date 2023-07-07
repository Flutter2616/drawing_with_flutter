import 'dart:ui';

import 'package:drawing_with_flutter/controller/drawing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Drawingscreen extends StatefulWidget {
  const Drawingscreen({super.key});

  @override
  State<Drawingscreen> createState() => _DrawingscreenState();
}

class _DrawingscreenState extends State<Drawingscreen> {
  Drawingcontroller controller = Get.put(Drawingcontroller());
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            setState(() {
              controller.points.clear();
              Customdrawing draw=Customdrawing(controller.points);
              draw.clear();
            });
          },
          child: Icon(Icons.close, color: Colors.white),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: Stack(
            children: [
              GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    RenderBox? renderBox =
                        context.findRenderObject() as RenderBox?;
                    controller.points.add(Drawingmodal(
                        Paint()
                          ..color = controller.currentcolor.value
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = controller.slider.value
                          ..isAntiAlias = true,
                        renderBox!.globalToLocal(details.globalPosition)));
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    controller.points.add(Drawingmodal(Paint(), Offset.zero));
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    RenderBox? renderBox =
                        context.findRenderObject() as RenderBox?;
                    controller.points.add(Drawingmodal(
                        Paint()
                          ..color = controller.currentcolor.value
                          ..strokeCap = StrokeCap.square
                          ..strokeWidth = controller.slider.value
                          ..isAntiAlias = true,
                        renderBox!.globalToLocal(details.globalPosition)));
                  });
                },
                child: Container(
                  width: 100.w,
                  height: 90.h,
                  child: CustomPaint(
                    painter: Customdrawing(controller.points),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 6.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade50),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: controller.colorlist
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(
                                        onTap: () {
                                          controller.currentcolor.value = e;
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: e,
                                          radius: 10.sp,
                                        )),
                                  ))
                              .toList()),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 70.h,
                        width: 10.w,
                        child: Obx(
                          () => SfSlider.vertical(
                            min: 0,
                            activeColor: controller.currentcolor.value,
                            inactiveColor: Colors.indigo.shade100,
                            max: 20,
                            value: controller.slider.value,
                            onChanged: (value) {
                              controller.slider.value = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Drawingmodal {
  Paint paint;
  Offset offset;

  Drawingmodal(this.paint, this.offset);
}

class Customdrawing extends CustomPainter {
  List<Drawingmodal> pointsList;

  Customdrawing(this.pointsList);

  List<Offset> offlist = [];

  void clear()
  {
    pointsList.clear();
    offlist.clear();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < (pointsList.length - 1); i++) {
      if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] != null) {
        offlist.clear();
        offlist.add(pointsList[i].offset);
        offlist.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offlist, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


