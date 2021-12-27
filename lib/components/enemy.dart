import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/animation.dart';
import 'package:flame_game/constans/constans.dart';
import 'package:flutter/cupertino.dart';

enum EnemyType { Hyena_walk, Snake_walk }

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColums;
  final int nRows;

  const EnemyData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColums,
    @required this.nRows,
  });
}

class Enemy extends AnimationComponent {
  double _speed = 250;
  Size size;
  int textureWidth;
  int textureHeight;

  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.Hyena_walk: EnemyData(
      imageName: "Hyena_walk.png",
      textureWidth: 48,
      textureHeight: 48,
      nColums: 6,
      nRows: 1,
    ),
    EnemyType.Snake_walk: EnemyData(
      imageName: "Snake_walk.png",
      textureWidth: 48,
      textureHeight: 48,
      nColums: 4,
      nRows: 1,
    ),
  };

  Enemy(EnemyType enemyType) : super.empty() {
    final enemyData = _enemyDetails[enemyType];
    final spriteSheet = SpriteSheet(
        imageName: enemyData.imageName,
        textureWidth: enemyData.textureWidth,
        textureHeight: enemyData.textureHeight,
        columns: enemyData.nColums,
        rows: enemyData.nRows);

    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: (enemyData.nColums - 1), stepTime: 0.1);
    textureWidth = enemyData.textureWidth;
    textureHeight = enemyData.textureHeight;
  }
  @override
  // ignore: unused_element
  void resize(Size size) {
    super.resize(size);

    double scaleFactor = (size.width / numberOfTitlesAlongWidht) / textureWidth;

    this.height = textureHeight * scaleFactor;
    this.width = textureWidth * scaleFactor;
    this.x = size.height + this.width;
    this.y = size.height - groundHeight - this.height;
    this.size = size;
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= _speed * t;
  }

  @override
  bool destroy() {
    return (this.x < (this.width));
  }
}
