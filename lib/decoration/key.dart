import 'package:bonfire/bonfire.dart';
import 'package:cloud_explorers/main.dart';
import 'package:cloud_explorers/player/knight.dart';

class DoorKey extends GameDecoration with Sensor {
  DoorKey(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load('items/key_silver.png'),
          position: position,
          size: Vector2(tileSize, tileSize),
        );

  @override
  void onContact(GameComponent collision) {
    if (collision is Knight) {
      collision.containKey = true;
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {
    // TODO: implement onContactExit
  }
}
