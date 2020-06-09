import 'package:digit_recognition/paints.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:tflite_flutter/tflite_flutter.dart';

class Strokes with ChangeNotifier {
  List<Offset> _points = <Offset>[];
  List<Offset> get points => _points;

  addAll(List<Offset> positions) {
    _points.addAll(positions);
    notifyListeners();
  }

  add(Offset position) {
    _points.add(position);
    notifyListeners();
  }

  clear() {
    _points.clear();
    notifyListeners();
  }
}

class DigitInterpreter with ChangeNotifier {
  // final _modelFile = 'mnist_float.tflite';
  final _modelFile = 'mnist_quantized.tflite';
  Interpreter _interpreter;
  ui.Image _image;
  ui.Image get image => _image;
  String _result = "Waiting for your digit";
  String get result => _result;

  DigitInterpreter() {
    _loadModel();
  }

  void clear() {
    _result = "Waiting for your digit";
  }

  void _loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelFile);
  }

  void update(Size size, List<Offset> points) async {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    // background
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        Paint()..color = Colors.black);
    // draw lines
    StrokePainter painter = StrokePainter(points: points);
    painter.paint(canvas, size);
    _image = await recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor()); // mnist image shape

    // preparing inputs and interpret
    List<double> input = await _toGrayScaleInput(_image, 280);
    var output = List<double>(10).reshape([1, 10]);
    _interpreter.run(input.reshape([1, 28, 28]), output);
    output = output.reshape([10]);
    double logitMax =
        output.reduce((value, element) => value > element ? value : element);
    _result = '${output.indexOf(logitMax)} (${logitMax.toStringAsFixed(4)})';

    notifyListeners();
  }

  Future<List<double>> _toGrayScaleInput(ui.Image image, int sx) async {
    final imageBytes = await image.toByteData();
    var input = List.generate(sx * sx, (index) => 4 * index)
        .map<double>((index) =>
            0.2126 * imageBytes.getUint8(index).toDouble() +
            0.7152 * imageBytes.getUint8(index + 1).toDouble() +
            0.0722 * imageBytes.getUint8(index + 2).toDouble())
        .map((e) => e / 255.0) // Normalize
        .toList();

    var input28 = List<double>(28 * 28).map((e) => 0.0).toList();

    for (int i = 0; i < sx; i++) {
      var indexI = i ~/ 10;
      for (int j = 0; j < sx; j++) {
        var indexJ = j ~/ 10;
        input28[indexI * 28 + indexJ] += input[i * 280 + j];
      }
    }
    return input28.map((e) => e / 100.0).toList();
  }
}
