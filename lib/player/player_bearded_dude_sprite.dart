import 'package:bonfire/bonfire.dart';

class BeardedDudeSprite {
  static late SpriteSheet sheet;

  // ゲーム起動時に実行するメソッド
  static Future<void> load() async {
    // sheet = await _create('charactors/bearded_dude.png');
    sheet = await _create('charactors/hero.png');
  }

  // 画像からSpriteSheetを生成するメソッド
  static Future<SpriteSheet> _create(String path) async {
    final image = await Flame.images.load(path);
    // return SpriteSheet.fromColumnsAndRows(image: image, columns: 8, rows: 4);
    return SpriteSheet.fromColumnsAndRows(image: image, columns: 6, rows: 2);
  }
}
