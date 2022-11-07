abstract class GameItem {
  GameItem({required this.imagePath, required this.jpName, required this.price});
  String imagePath;
  String jpName;
  int price;
}

class BigShroom extends GameItem {
  BigShroom()
      : super(
          // imagePath: 'objects/big_shroom.png',
          imagePath: 'objects/red_potion.png',
          jpName: 'デカキノコ',
          price: 120,
        );
}
