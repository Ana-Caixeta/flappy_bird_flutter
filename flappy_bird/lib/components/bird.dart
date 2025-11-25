import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flutter/material.dart';


class Bird extends SpriteGroupComponent<BirdMovement> 
  with HasGameReference<FlappyBirdGame>, CollisionCallbacks {
    Bird();

    int score = 0;

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
      add(CircleHitbox());
    }

    void fly() {
      add(
        MoveByEffect(
          Vector2(0, Config.gravity),
          EffectController(duration: 0.2, curve: Curves.decelerate),
          onComplete: () => current = BirdMovement.down,
        )
      );
      current = BirdMovement.up;
    }

    @override
    void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
    ) {
      super.onCollisionStart(intersectionPoints, other);
    }

    void gameOver() {
      game.overlays.add('gameOver');
      game.pauseEngine();
    }

    @override
    void update(double dt){
      super.update(dt);
      position.y += Config.birdVelocity * dt;
    }
}
