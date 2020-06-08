import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/painting.dart' show decodeImageFromList;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  Future<ui.Image> loadImageAsset(String assetName) async {
    final data = await rootBundle.load(assetName);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  double bound(double x, double lb, double ub) {
    if (x < lb) {
      return 0.0;
    } else {
      return (x > ub) ? ub : x;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detection'),
      ),
      body: FutureBuilder(
        future: loadImageAsset('assets/people3.jpg'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final ui.Image image = snapshot.data;
            final height = image.height.toDouble();
            final width = image.width.toDouble();
            // do some heavy calculation on boxes here
            final faces = List<Rect>();
            List<List<double>> boxes = [
              [352.97855, 478.7657, 590.62915, 774.46204],
              [798.4486, 139.60591, 1036.2827, 399.42282],
              [103.932045, 187.5462, 252.63231, 352.43588],
              [521.2908, 112.58168, 648.74536, 271.44614],
              [358.31802, 90.538445, 472.7941, 232.20035]
            ];
            for (var i = 0; i < boxes.length; i++) {
              var x1 = bound(boxes[i][0], 0.0, width);
              var x2 = bound(boxes[i][2], 0.0, width);
              var y1 = bound(boxes[i][1], 0.0, height);
              var y2 = bound(boxes[i][3], 0.0, height);
              faces.add(Rect.fromPoints(Offset(x1, y1), Offset(x2, y2)));
            }

            return Container(
              decoration: BoxDecoration(border: Border.all()),
              child: FittedBox(
                child: SizedBox(
                  width: image.width.toDouble(),
                  height: image.width.toDouble(),
                  child: CustomPaint(
                    painter: FacePainter(image: image, faces: faces),
                    // size: Size.infinite,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  FacePainter({this.image, this.faces, this.points});
  final ui.Image image;
  final List<Rect> faces;
  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paintBox = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawImage(image, Offset.zero, Paint());

    for (int i = 0; i < faces.length; i++) {
      canvas.drawRect(faces[i], paintBox);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
