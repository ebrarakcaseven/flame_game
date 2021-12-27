import 'dart:ffi';
import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/animation.dart';

class Enemy extends AnimationComponent {
  SpriteSheet gameSpritesheet;
  Animation _runAnimation;
  double _speed = 100;
  Enemy() : super.empty() {
    gameSpritesheet = SpriteSheet(
        imageName: "Hyena_walk.png",
        textureWidth: 48,
        textureHeight: 48,
        columns: 6,
        rows: 1);

    _runAnimation =
        gameSpritesheet.createAnimation(0, from: 0, to: 5, stepTime: 0.1);
    animation = _runAnimation;
  }
  @override
  // ignore: unused_element
  void resize(Size size) {
    height = width = size.width / 7;

    x = size.width + width;
    y = size.height - 10 - height;

    super.resize(size);
  }

  @override
  void update(double t) {
    x -= x - (_speed * t);
    super.update(t);
  }
}
