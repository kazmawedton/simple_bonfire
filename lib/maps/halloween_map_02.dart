import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:simple_bonfire/decorations/big_shroom.dart';
import 'package:simple_bonfire/decorations/scarecrow.dart';
import 'package:simple_bonfire/maps/halloween_map_01.dart';
import 'package:simple_bonfire/npc/npc_house_mother.dart';
import 'package:simple_bonfire/npc/npc_house_mother_sprite.dart';
import 'package:simple_bonfire/player/player_bearded_dude.dart';
import 'package:simple_bonfire/player/player_bearded_dude_sprite.dart';
import 'package:simple_bonfire/utilities/exit_map_sensor.dart';

class HalloweenMap02 extends StatefulWidget {
  const HalloweenMap02({Key? key}) : super(key: key);
  @override
  State<HalloweenMap02> createState() => _HalloweenMap02State();
}

class _HalloweenMap02State extends State<HalloweenMap02> {
  final tileSize = 48.0; // タイルのサイズ定義
  late NpcHouseMother npcHouseMother;

  @override
  Widget build(BuildContext context) {
    // 画面
    return BonfireWidget(
      // showCollisionArea: true,
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        'maps/simple_dungeon_02.json',
        // 'maps/halloween_map_02.json',
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {
          'houseMother': (properties) {
            npcHouseMother = NpcHouseMother(
              properties.position,
              HouseMotherSprite.sheet,
            );
            return npcHouseMother;
          },
          'bottomExitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: const HalloweenMap01(),
              ),
        },
      ),
      // プレイヤーキャラクター
      player: PlayerBeardedDude(
        Vector2(tileSize * 7.5, tileSize * 9.5),
        // Vector2(tileSize * 9.5, tileSize * 11.5),
        spriteSheet: BeardedDudeSprite.sheet,
        initDirection: Direction.up,
      ),
      // デコレーションの配置
      onReady: (game) {
        _addGameItems(game);
        _addScarecrow(game);
        game.addJoystickObserver(npcHouseMother);
      },
      // カメラ設定
      cameraConfig: CameraConfig(
        zoom: 1.25,
        moveOnlyMapArea: false,
        sizeMovementWindow: Vector2.zero(),
        smoothCameraEnabled: true,
        smoothCameraSpeed: 10,
      ),
      // 入力インターフェースの設定
      joystick: Joystick(
        // 画面上のジョイスティック追加
        directional: JoystickDirectional(
          color: Colors.white,
        ),
        actions: [
          // 画面上のアクションボタン追加
          JoystickAction(
            color: Colors.white,
            actionId: 1,
            margin: const EdgeInsets.all(65),
          ),
        ],
        // キーボード用入力の設定
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
          acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
        ),
      ),
      // ロード中の画面の設定
      progress: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black,
      ),
    );
  }

  void _addGameItems(BonfireGame game) {
    game.add(
      BigShroomDecoration(
        initPosition: Vector2(tileSize * 9, tileSize * 3),
        map: widget.runtimeType,
        id: 0,
        player: game.player! as PlayerBeardedDude,
      ),
    );
    game.add(
      BigShroomDecoration(
        initPosition: Vector2(tileSize * 13, tileSize * 4),
        map: widget.runtimeType,
        id: 1,
        player: game.player! as PlayerBeardedDude,
      ),
    );
  }

  void _addScarecrow(BonfireGame game) {
    game.add(ScarecrowDecoration(
      initPosition: Vector2(tileSize * 13, tileSize * 2),
    ));
  }
}
