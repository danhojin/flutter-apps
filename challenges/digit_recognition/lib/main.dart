import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digit recognizer',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digit recognizer'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HandPaint(),
            Text('World'),
          ],
        ),
      ),
    );
  }
}

class HandPaint extends StatefulWidget {
  @override
  _HandPaintState createState() => _HandPaintState();
}

class _HandPaintState extends State<HandPaint> {
  List<Offset> _points = <Offset>[];

  _onPanUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox renderBox = context.findRenderObject();
    var points = renderBox.globalToLocal(details.globalPosition);
    setState(() {
      _points = List.from(_points)..add(points);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(),
        ),
        child: GestureDetector(
          onPanUpdate: (details) => _onPanUpdate(context, details),
          onPanEnd: (details) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            painter: HandPainter(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class HandPainter extends CustomPainter {
  final List<Offset> points;

  HandPainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 13.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(HandPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
