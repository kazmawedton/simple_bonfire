import 'package:bonfire/bonfire.dart';
import 'package:simple_bonfire/player/player_bearded_dude.dart';
import 'package:simple_bonfire/model/game_item.dart';

class BigShroomDecoration extends GameDecoration with Sensor {
  BigShroomDecoration(
      {required this.initPosition, required this.map, required this.id, required this.player})
      : super.withSprite(
          sprite: Sprite.load(gameItem.imagePath),
          position: initPosition,
          size: Vector2(48, 48),
        ) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(size: size, align: Vector2.zero()),
    ]);
  }
  static final gameItem = BigShroom();

  final Vector2 initPosition;
  final Type map;
  final int id;
  final PlayerBeardedDude player;

  @override
  void onMount() {
    super.onMount();
    if (player.controller.itemObtained[map] != null &&
        player.controller.itemObtained[map]!.contains(id)) {
      removeFromParent();
    }
  }

  @override
  void onContact(GameComponent component) {
    if (component == player) {
      if (player.controller.itemCounts[gameItem] == null) {
        player.controller.itemCounts[gameItem] = 0;
      }
      player.controller.itemCounts[gameItem] = player.controller.itemCounts[gameItem]! + 1;

      if (player.controller.itemObtained[map] == null) {
        player.controller.itemObtained[map] = {};
      }
      player.controller.itemObtained[map]!.add(id);

      removeFromParent();
    }
  }
}
