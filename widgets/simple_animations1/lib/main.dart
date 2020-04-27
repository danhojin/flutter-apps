import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Center(
            child: Page2(),
          ),
          Center(
            child: Page3(),
          ),
          Center(
            child: Page4(),
          ),
          Center(
            child: Page5(),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: (0.0).tweenTo(200.0),
      duration: 2.seconds,
      curve: Curves.easeOut,
      child: Center(child: Text('Hello!')),
      builder: (context, child, value) {
        return Container(
          width: value,
          height: value,
          color: Colors.green,
          child: child,
        );
      },
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return PlayAnimation<double>(
      tween: 0.0.tweenTo(width),
      duration: 2.seconds,
      delay: 1.seconds,
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return Container(
          height: 50.0 - 45.0 / width * value,
          width: value,
          color: Colors.orange,
        );
      },
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // try also MirrorAnimation
    return LoopAnimation<double>(
      duration: 2.seconds,
      tween: (0.0).tweenTo(10.0),
      child: Text('Hello!'),
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  CustomAnimationControl control = CustomAnimationControl.PLAY;

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      control: control,
      tween: (-100.0).tweenTo(100.0),
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(value, 0.0),
          child: child,
        );
      },
      child: MaterialButton(
        color: Colors.yellow,
        child: Text('Swap'),
        onPressed: toggleDirection,
      ),
    );
  }

  void toggleDirection() {
    setState(() {
      control = (control == CustomAnimationControl.PLAY)
          ? CustomAnimationControl.PLAY_REVERSE
          : CustomAnimationControl.PLAY;
    });
  }
}