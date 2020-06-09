import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'paints.dart';
import 'providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DigitInterpreter(),
        ),
        ChangeNotifierProvider(
          create: (context) => Strokes(),
        ),
      ],
      child: MaterialApp(
        title: 'Digit recognizer',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final digitInterperterProvider =
        Provider.of<DigitInterpreter>(context, listen: true);
    final strokesProvider = Provider.of<Strokes>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Digit recognizer'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DigitPaint(
              points: strokesProvider.points,
            ),
            Text(digitInterperterProvider.result),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          strokesProvider.clear();
          digitInterperterProvider.clear();
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}

class BirdEyePainter extends CustomPainter {
  final ui.Image image;

  BirdEyePainter(this.image);

  @override
  void paint(ui.Canvas canvas, Size size) {
    canvas.drawImage(image, Offset(0.0, 0.0), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
