import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;


Future<Uint8List> getBytesFromCanvas(String text) async {

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint1 = Paint()..color = Colors.grey;
  const int size = 100; //change this according to your app
  canvas.drawCircle(const Offset(size / 2, size / 2), size / 2.0, paint1);
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: text,//you can write your own text here or take from parameter
    style: const TextStyle(
        fontSize: size / 4, color: Colors.red, fontWeight: FontWeight.bold),
  );
  painter.layout();
  painter.paint(
    canvas,
    Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
  );

  final img = await pictureRecorder.endRecording().toImage(size, size);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}