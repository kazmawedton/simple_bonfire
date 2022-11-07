import 'package:bonfire/bonfire.dart';

class EmoteBubble {
  static Future<SpriteAnimation> get exclamacao => SpriteAnimation.load(
        "ui/exclamacao_bubble.png",
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.08,
          textureSize: Vector2(12, 12),
        ),
      );
}
