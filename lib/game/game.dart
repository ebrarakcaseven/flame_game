import 'package:flame/components/parallax_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_game/components/character.dart';
import 'package:flame_game/components/enemy.dart';

class Game extends BaseGame with TapDetector {
  Character _character;
  Enemy _enemy;
  ParallaxComponent _parallaxComponent;
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
    _character.run();
    add(_character);
    _enemy = Enemy();
    add(_enemy);
  }

  @override
  void onTapDown(TapDownDetails details) {
    _character.jump();
    super.onTapDown(details);
  }
}
