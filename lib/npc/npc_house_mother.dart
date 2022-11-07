import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_bonfire/utilities/custom_talk_animation.dart';
import 'package:simple_bonfire/utilities/emote_bubble.dart';

class NpcHouseMother extends SimpleNpc
    with ObjectCollision, JoystickListener, AutomaticRandomMovement, Pushable {
  NpcHouseMother(Vector2 position, SpriteSheet spriteSheet,
      {Direction initDirection = Direction.right})
      : super(
          animation: SimpleDirectionAnimation(
            enabledFlipX: true,
            idleRight: spriteSheet.createAnimation(row: 0, stepTime: 0.7, to: 6).asFuture(),
            runRight: spriteSheet.createAnimation(row: 1, stepTime: 0.2, to: 6).asFuture(),
            // idleRight:
            // spriteSheet.createAnimation(row: 2, stepTime: 0.7, from: 1, to: 3).asFuture(),
            // idleLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.6, from: 1, to: 3).asFuture(),
            // idleDown: spriteSheet.createAnimation(row: 0, stepTime: 0.6, from: 1, to: 3).asFuture(),
            // idleUp: spriteSheet.createAnimation(row: 3, stepTime: 0.6, from: 1, to: 3).asFuture(),
            // runRight: spriteSheet.createAnimation(row: 2, stepTime: 0.2, from: 4, to: 8).asFuture(),
            // runLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.2, from: 4, to: 8).asFuture(),
            // runDown: spriteSheet.createAnimation(row: 0, stepTime: 0.2, from: 4, to: 8).asFuture(),
            // runUp: spriteSheet.createAnimation(row: 3, stepTime: 0.2, from: 4, to: 8).asFuture(),
          ),
          size: Vector2(16, 16) * 3,
          // size: Vector2(16, 24) * 3,
          position: position,
          initDirection: initDirection,
          speed: 32,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(sizeNpc.x, sizeNpc.y * 0.5),
            align: Vector2(0, sizeNpc.y * 0.5),
          ),
        ],
      ),
    );
  }

  static final sizeNpc = Vector2(16, 23) * 3;
  static const radiusVision = 54.0;

  bool lookAtPlayer = false;

  @override
  void update(double dt) {
    seePlayer(
      observed: (player) {
        if (!lookAtPlayer) {
          _showExclamacao();
          lookAtPlayer = true;
        }
        _faceToPlayer(player);
      },
      notObserved: () {
        if (lookAtPlayer) {
          lookAtPlayer = false;
        }
      },
      radiusVision: radiusVision,
    );

    if (!lookAtPlayer) {
      runRandomMovement(
        dt,
        speed: speed,
        maxDistance: (speed * 3).toInt(),
        timeKeepStopped: 3000,
      );
    }

    super.update(dt);
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    if (enablePushable) {
      if (!onPush(component)) {
        return super.onCollision(component, active);
      }
      Vector2 displacement = center - component.center;
      if (displacement.x.abs() > displacement.y.abs()) {
        if (displacement.x < 0) {
          moveLeft(speed);
        } else {
          moveRight(speed);
        }
      } else {
        if (displacement.y < 0) {
          moveUp(speed);
        } else {
          moveDown(speed);
        }
      }
      _faceToPlayer(component);
    }
    // return super.onCollision(component, active);
    return true;
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if ((event.id == 1 || event.id == LogicalKeyboardKey.space.keyId) &&
        event.event == ActionEvent.DOWN &&
        lookAtPlayer) {
      _showTalk();
    }
    super.joystickAction(event);
  }

  void _faceToPlayer(GameComponent player) {
    final displacement = player.center - center;
    final tangent = displacement.y / displacement.x;

    if (-1 < tangent && tangent < 1) {
      if (0 < displacement.x) {
        animation!.play(SimpleAnimationEnum.idleRight);
      } else {
        animation!.play(SimpleAnimationEnum.idleLeft);
      }
    }
    // else {
    //   if (0 < displacement.y) {
    //     animation!.play(SimpleAnimationEnum.idleDown);
    //   } else {
    //     animation!.play(SimpleAnimationEnum.idleUp);
    //   }
    // }
  }

  void _showTalk() {
    gameRef.camera.moveToTargetAnimated(this);
    TalkDialog.show(
      context,
      [
        Say(
          text: [const TextSpan(text: 'カボチャはカボチャでも、食べられないカボチャって、一体何だと思う？')],
          person: CustomTalkAnimationWidget(
            animation: animation!.idleRight!.asFuture(),
            size: size,
          ),
          // personSayDirection: PersonSayDirection.LEFT,
          // person: CustomTalkAnimationWidget(
          //   animation: animation!.idleDown!.asFuture(),
          //   size: size,
          // ),
        ),
        Say(
          text: [const TextSpan(text: 'うふふっ、君にはちょっと難しいかったかな…')],
          person: CustomTalkAnimationWidget(
            animation: animation!.idleRight!.asFuture(),
            size: size,
          ),
          // personSayDirection: PersonSayDirection.LEFT,
          // person: CustomTalkAnimationWidget(
          //   animation: animation!.idleDown!.asFuture(),
          //   size: size,
          // ),
        ),
        Say(
          text: [const TextSpan(text: '答えは、腐ったカボチャよ！')],
          person: CustomTalkAnimationWidget(
            animation: animation!.idleRight!.asFuture(),
            size: size,
          ),
          // personSayDirection: PersonSayDirection.LEFT,
          // person: CustomTalkAnimationWidget(
          //   animation: animation!.idleDown!.asFuture(),
          //   size: size,
          // ),
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
      onFinish: () {
        gameRef.camera.moveToTargetAnimated(gameRef.player!);
      },
    );
  }

  void _showExclamacao() {
    add(
      AnimatedFollowerObject(
        animation: EmoteBubble.exclamacao,
        target: this,
        size: Vector2.all(32),
        positionFromTarget: Vector2(8, -18),
      ),
    );
  }
}
