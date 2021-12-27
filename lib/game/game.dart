import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame_game/components/enemy_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_game/components/character.dart';
import 'package:flame_game/components/enemy.dart';

class Game extends BaseGame with TapDetector {
  Character _character;
  ParallaxComponent _parallaxComponent;
  TextComponent _scoreText;
  int score;
  EnemyManager _enemyManager;
  Enemy _enemy;
  Game() {
    _parallaxComponent = ParallaxComponent([
      ParallaxImage("parallax/7.png"),
      ParallaxImage("parallax/6.png"),
      ParallaxImage("parallax/5.png"),
      ParallaxImage("parallax/4.png"),
      ParallaxImage("parallax/2.png"),
      ParallaxImage("parallax/1.png"),
    ], baseSpeed: const Offset(100, 0), layerDelta: const Offset(20, 0));

    add(_parallaxComponent);

    _character = Character();
    add(_character);

    _enemyManager = EnemyManager();
    add(_enemyManager);

    score = 0;
    _scoreText = TextComponent(score.toString());
    add(_scoreText);
  }

  void resize(Size size) {
    super.resize(size);
    _scoreText.setByPosition(
        Position(((size.width / 2) - (_scoreText.width / 2)), 0));
  }

  @override
  void onTapDown(TapDownDetails details) {
    _character.jump();
    super.onTapDown(details);
  }

  @override
  void update(double t) {
    super.update(t);
    score += (60 * t).toInt();
    _scoreText.text = score.toString();
  }
}
