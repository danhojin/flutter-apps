import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/lake.jpg',
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 100.0,
                  left: 20.0,
                  child: Text(
                    'ClipPath',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // bezier three points
    var p = List<Offset>();
    p.add(Offset(0.0, size.height - 70.0));
    p.add(Offset(size.width * 0.4, size.height - 60.0));
    p.add(Offset(size.width, size.height - 30));
    var c = controlpoints(p[1], [0.2, 0.7], 0.3, size);
    path.lineTo(p[0].dx, p[0].dy);
    for (var i = 0; i < 2; i++) {
      path.quadraticBezierTo(c[i].dx, c[i].dy, p[i + 1].dx, p[i + 1].dy);
    }
    // closing
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  List<Offset> controlpoints(
      Offset p1, List<double> t, double slope, Size size) {
    var x1 = p1.dx;
    var y1 = p1.dy;
    var c = List<Offset>();
    for (var i = 0; i < t.length; i++) {
      var x = size.width * t[i];
      var y = y1 + slope * (x - x1);
      c.add(Offset(x, y));
    }
    return c;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
