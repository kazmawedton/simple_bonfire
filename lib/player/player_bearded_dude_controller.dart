import 'package:bonfire/bonfire.dart';
import 'package:simple_bonfire/model/game_item.dart';
import 'package:simple_bonfire/player/player_bearded_dude.dart';

class BearedDudeController extends StateController<PlayerBeardedDude> {
  Map<GameItem, int> itemCounts = {}; // 持っているアイテムの数
  Map<Type, Set<int>> itemObtained = {}; // マップごとの取得済みアイテム

  @override
  void update(dt, component) {}
}
