import 'package:flame/components.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/assets.dart';


class Bird extends SpriteGroupComponent<BirdMovement> with HasGameReference<FlappyBirdGame>{
  Bird();

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await game.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await game.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await game.loadSprite(Assets.birdDownFlap);

    game.bird;

    size = Vector2(50, 40);
    position = Vector2(50, game.size.y / 2 - size.y / 2);
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };
    current = BirdMovement.middle;
  }
}
