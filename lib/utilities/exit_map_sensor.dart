import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:simple_bonfire/utilities/extentions.dart';

class ExitMapSensor extends GameDecoration with Sensor {
  ExitMapSensor({required Vector2 position, required Vector2 size, required this.nextMap})
      : super(position: position, size: size);
  // 移動先のマップ
  Widget nextMap;
  // 連続実行防止用
  bool hasContact = false;

  @override
  void onContact(component) {
    if (!hasContact && component is Player) {
      hasContact = true;
      context.goTo(nextMap);
    }
  }
}
