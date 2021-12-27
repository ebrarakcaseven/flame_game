import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/rendering.dart';

const GRAVITY = 1000;

class Character extends AnimationComponent {
  SpriteSheet gameSpritesheet;
  Animation _runAnimation;
  Animation _hitAnimation;
  double speedY = 0.0;
  double maxY = 0.0;
  Character() : super.empty() {
    gameSpritesheet = SpriteSheet(
        imageName: "cat_spritesheet.png",
        textureWidth: 32,
        textureHeight: 32,
        columns: 8,
        rows: 10);

    _runAnimation =
        gameSpritesheet.createAnimation(4, from: 0, to: 7, stepTime: 0.1);

    _hitAnimation =
        gameSpritesheet.createAnimation(9, from: 0, to: 7, stepTime: 0.1);
    animation = _runAnimation;
  }

  bool isOnGround() {
    return (y >= maxY);
  }

  @override
  void resize(Size size) {
    height = width = size.width / 10;

    x = width;
    y = size.height - 50 - height;

    maxY = y;
    super.resize(size);
  }

  void update(double t) {
    speedY = speedY + GRAVITY * t;

    y = y + speedY * t;

    if (isOnGround()) {
      y = maxY;
      speedY = 0;
    }

    super.update(t);
  }

  void run() {
    animation = _runAnimation;
  }

  void hit() {
    animation = _hitAnimation;
  }

  void jump() {
    if (isOnGround()) {
      speedY = -600;
    }
  }
}
