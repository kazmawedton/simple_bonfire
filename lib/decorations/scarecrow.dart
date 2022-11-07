import 'package:bonfire/bonfire.dart';
import 'package:simple_bonfire/maps/halloween_map_02.dart';
import 'package:simple_bonfire/player/player_bearded_dude_controller.dart';

class ScarecrowDecoration extends GameDecoration with ObjectCollision {
  ScarecrowDecoration({required this.initPosition})
      : super.withSprite(
          sprite: Sprite.load(imagePath),
          position: initPosition,
          size: Vector2.all(48),
          // position: initPosition - Vector2(0, -48),
          // size: Vector2(48, 96),
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: Vector2(48, 24), align: Vector2(0, 24)),
          // CollisionArea.rectangle(size: Vector2(12, 18), align: Vector2(18, 78)),
        ],
      ),
    );
  }
  final Vector2 initPosition;

  static const imagePathOn = 'objects/chest_open.png';
  static const imagePath = 'objects/chest_close.png';
  // static const imagePathOn = 'objects/scarecrow_pumpkin_on.png';
  // static const imagePath = 'objects/scarecrow_pumpkin_off.png';

  final controller = BonfireInjector().get<BearedDudeController>();
  bool lightOn = false;

  @override
  void update(dt) async {
    final itemObtained = controller.itemObtained[HalloweenMap02];
    if (itemObtained != null && itemObtained.containsAll({0, 1})) {
      sprite = await Sprite.load(imagePathOn);
      // setupCollision(
      //   CollisionConfig(collisions: []),
      // );
      lightOn = true;
    }
    super.update(dt);
  }
}
