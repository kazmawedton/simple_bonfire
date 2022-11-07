import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bonfire/bonfire.dart';
import 'package:simple_bonfire/maps/halloween_map_02.dart';
import 'package:simple_bonfire/npc/npc_house_mother_sprite.dart';
import 'package:simple_bonfire/player/player_bearded_dude_controller.dart';
import 'package:simple_bonfire/player/player_bearded_dude_sprite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  await BeardedDudeSprite.load();
  await HouseMotherSprite.load();

  // Stateコントローラー
  BonfireInjector().put((i) => BearedDudeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Bonfire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DotGothic16',
      ),
      home: const HalloweenMap02(),
    );
  }
}
