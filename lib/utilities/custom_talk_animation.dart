import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class CustomTalkAnimationWidget extends StatelessWidget {
  const CustomTalkAnimationWidget({Key? key, required this.animation, required this.size})
      : super(key: key);

  final Future<SpriteAnimation> animation;
  final Vector2 size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.x,
      height: size.y,
      child: animation.asWidget(),
    );
  }
}
