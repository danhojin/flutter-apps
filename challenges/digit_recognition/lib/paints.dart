import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers.dart';

class DigitPaint extends StatelessWidget {
  final List<Offset> points;

  const DigitPaint({Key key, this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strokesProvider = Provider.of<Strokes>(context, listen: true);
    final digitInterpreterProvider =
        Provider.of<DigitInterpreter>(context, listen: false);

    return ClipRect(
      child: Container(
        height: 280.0,
        width: 280.0,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(),
        ),
        child: GestureDetector(
          onPanUpdate: (details) {
            RenderBox renderBox = context.findRenderObject();
            Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            strokesProvider.add(localPosition);
          },
          onPanEnd: (details) {
            digitInterpreterProvider.update(
                context.size, strokesProvider.points);
            strokesProvider.add(null);
          },
          child: CustomPaint(
            painter: StrokePainter(points: strokesProvider.points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class StrokePainter extends CustomPainter {
  final List<Offset> points;

  StrokePainter({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) {
    return true;
  }
}
