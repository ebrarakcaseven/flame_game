import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/rendering.dart';

// ignore: constant_identifier_names
const GRAVITY = 1000;

class Character extends AnimationComponent {
  SpriteSheet gameSpritesheet;
  Animation _runAnimation;
  Animation _hitAnimation;
  double speedY = 0.0;
  double maxY = 0.0;
  bool isHit;
  Timer _timer;
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
    isHit = false;
    _timer = Timer(
      2,
      callback: () {
        run();
      },
      repeat: true,
    );
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

  @override
  void update(double t) {
    speedY = speedY + GRAVITY * t;

    y = y + speedY * t;

    if (isOnGround()) {
      y = maxY;
      speedY = 0;
    }
    _timer.update(t);
    super.update(t);
  }

  void run() {
    animation = _runAnimation;
  }

  void hit() {
    if (!isHit) {
      isHit = true;
      animation = _hitAnimation;
      _timer.start();
    }
  }

  void jump() {
    if (isOnGround()) {
      speedY = -600;
    }
  }
}
