import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:simple_bonfire/maps/halloween_map_02.dart';
import 'package:simple_bonfire/player/player_bearded_dude.dart';
import 'package:simple_bonfire/player/player_bearded_dude_sprite.dart';
import 'package:simple_bonfire/utilities/exit_map_sensor.dart';

class HalloweenMap01 extends StatefulWidget {
  const HalloweenMap01({Key? key}) : super(key: key);
  @override
  State<HalloweenMap01> createState() => _HalloweenMap01State();
}

class _HalloweenMap01State extends State<HalloweenMap01> {
  final tileSize = 48.0; // タイルのサイズ定義

  @override
  Widget build(BuildContext context) {
    // 画面
    return BonfireWidget(
      // showCollisionArea: true,
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        'maps/simple_dungeon_01.json',
        // 'maps/halloween_map_01.json',
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {
          'bottomExitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: const HalloweenMap02(),
              ),
        },
      ),
      // プレイヤーキャラクター
      player: PlayerBeardedDude(
        Vector2(tileSize * 7.5, tileSize * 1),
        // Vector2(tileSize * 10, tileSize * 7.5),
        spriteSheet: BeardedDudeSprite.sheet,
        initDirection: Direction.down,
      ),
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
}
