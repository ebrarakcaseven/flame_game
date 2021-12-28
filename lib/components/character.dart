// ignore_for_file: unnecessary_this
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flame_game/constans/constans.dart';

class Character extends AnimationComponent {
  Animation _runAnimation;
  Animation _hitAnimation;
  Timer _timer;
  bool _isHit;
  double speedY = 0.0;
  double maxY = 0.0;
  ValueNotifier<int> life;
  Character() : super.empty() {
    // ignore: non_constant_identifier_names, unused_local_variable
    final Spritesheet = SpriteSheet(
        imageName: "cat_spritesheet.png",
        textureWidth: 32,
        textureHeight: 32,
        columns: 8,
        rows: 10);

    _runAnimation =
        Spritesheet.createAnimation(4, from: 0, to: 7, stepTime: 0.1);

    _hitAnimation =
        Spritesheet.createAnimation(8, from: 1, to: 2, stepTime: 0.1);

    this.animation = _runAnimation;

    _timer = Timer(2, callback: () {
      run();
    });
    _isHit = false;

    life = ValueNotifier(5);
  }
  @override
  void resize(Size size) {
    super.resize(size);
    this.height = this.width = size.width / 10;
    this.x = this.width;

    this.y = size.height - 30 - this.height;
    this.maxY = this.y;
  }

  @override
  void update(double t) {
    super.update(t);
    this.speedY += GRAVITY * t;

    this.y += this.speedY * t;

    if (isOnGround()) {
      this.y = this.maxY;
      this.speedY = 0.0;
    }
    _timer.update(t);
  }

  bool isOnGround() {
    return (this.y >= this.maxY);
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit() {
    if (!_isHit) {
      _isHit = true;
      this.animation = _hitAnimation;
      life.value -= 1;
      _timer.start();
    }
  }

  void jump() {
    if (isOnGround()) {
      speedY = -450;
    }
  }
}
