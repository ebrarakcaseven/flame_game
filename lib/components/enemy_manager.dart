import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame_game/game/game.dart';
import 'package:flame/time.dart';
import 'package:flame_game/components/enemy.dart';
import 'package:flutter/widgets.dart';

class EnemyManager extends Component with HasGameRef<Game> {
  Random _random;
  Timer _timer;
  EnemyManager() {
    _random = Random();
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }
  void spawnRandomEnemy() {
    final randomNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randomNumber);
    final newEnemy = Enemy(randomEnemyType);
    gameRef.addLater(newEnemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {}
  @override
  void update(double t) {
    _timer.update(t);
  }
}
