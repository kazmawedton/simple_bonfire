import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:simple_bonfire/player/player_bearded_dude_controller.dart';

class PlayerBeardedDude extends SimplePlayer
    with ObjectCollision, UseStateController<BearedDudeController> {
  PlayerBeardedDude(
    position, {
    required this.spriteSheet,
    Direction initDirection = Direction.down,
  }) : super(
          animation: SimpleDirectionAnimation(
            enabledFlipX: true,
            idleRight: spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 6).asFuture(),
            runRight: spriteSheet.createAnimation(row: 1, stepTime: 0.08, to: 6).asFuture(),
            // idleDown: spriteSheet.createAnimation(row: 0, stepTime: 0.4, from: 1, to: 3).asFuture(),
            // idleLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.4, from: 1, to: 3).asFuture(),
            // idleRight:
            //     spriteSheet.createAnimation(row: 2, stepTime: 0.4, from: 1, to: 3).asFuture(),
            // idleUp: spriteSheet.createAnimation(row: 3, stepTime: 0.4, from: 1, to: 3).asFuture(),
            // runDown: spriteSheet.createAnimation(row: 0, stepTime: 0.1, from: 4, to: 8).asFuture(),
            // runLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.1, from: 4, to: 8).asFuture(),
            // runRight: spriteSheet.createAnimation(row: 2, stepTime: 0.1, from: 4, to: 8).asFuture(),
            // runUp: spriteSheet.createAnimation(row: 3, stepTime: 0.1, from: 4, to: 8).asFuture(),
          ),
          size: Vector2(16, 16) * 3,
          // size: Vector2(16, 24) * 3,
          position: position,
          initDirection: initDirection,
          speed: 80 * 3,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(size.x * 12 / 16, size.y * 8 / 24),
            align: Vector2(size.x * 2 / 16, size.y * 15 / 24),
          ),
        ],
      ),
    );
    setupMoveToPositionAlongThePath(
      pathLineColor: Colors.transparent,
      barriersCalculatedColor: Colors.transparent,
    );
  }
  final SpriteSheet spriteSheet;
}
