import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'configuration.dart';
import '../components/pipe_group.dart';
import 'package:flutter/painting.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
      score = buildScore(),
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        priority: 100,
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    bird.fly();
  }

  @override
  void update(double dt){
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}