import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, offset }

class FadeInAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeInAnimation({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 1.4.seconds)
      ..add(AniProps.offset,
          Tween(begin: Offset(0.0, 120.0), end: Offset(0.0, 0.0)), 0.5.seconds);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      tween: tween,
      duration: tween.duration,
      delay: delay.seconds,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
            offset: value.get(AniProps.offset),
            child: child,
          ),
        );
      },
    );
  }
}
