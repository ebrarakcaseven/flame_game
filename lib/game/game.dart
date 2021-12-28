import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame_game/components/enemy_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_game/components/character.dart';
import 'package:flame_game/components/enemy.dart';
import 'package:flutter/material.dart';

class Game extends BaseGame with TapDetector, HasWidgetsOverlay {
  Character _character;
  ParallaxComponent _parallaxComponent;
  TextComponent _scoreText;
  int score;
  EnemyManager _enemyManager;
  // ignore: unused_field
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
    _scoreText = TextComponent(score.toString(),
        config: TextConfig(color: Colors.white));
    add(_scoreText);

    addWidgetOverlay('Hud', _builHud());
  }

  @override
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

    components.whereType<Enemy>().forEach((enemy) {
      if (_character.distance(enemy) < 20) {
        _character.hit();
      }
    });
    if (_character.life.value <= 0) {
      gameOver();
    }
  }

  Widget _builHud() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.pause, color: Colors.white, size: 25.0),
          onPressed: () {
            pauseGame();
          },
        ),
        ValueListenableBuilder(
          valueListenable: _character.life,
          builder: (BuildContext context, value, Widget child) {
            // ignore: deprecated_member_use, prefer_collection_literals
            final list = List<Widget>();

            for (int i = 0; i < 5; i++) {
              list.add(Icon(
                  (i < value) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red));
            }
            return Row(
              children: list,
            );
          },
        )
      ],
    );
  }

  void pauseGame() {
    pauseEngine();
    addWidgetOverlay('PauseMenu', _buildPauseMenu());
  }

  Widget _buildPauseMenu() {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Paused',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  resumeGame();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
  }

  // ignore: missing_return
  Widget _getGameOverMenu() {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              Text(
                'Your Score Was $score',
                style: const TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  reset();
                  removeWidgetOverlay('GameOverMenu');
                  resumeEngine();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void gameOver() {
    pauseEngine();
    addWidgetOverlay('GameOverMenu', _getGameOverMenu());
  }

  void reset() {
    // ignore: unnecessary_this
    this.score = 0;
    _character.life.value = 5;
    _character.run();
    _enemyManager.reset();

    components.whereType<Enemy>().forEach(
      (enemy) {
        // ignore: unnecessary_this
        this.markToRemove(enemy);
      },
    );
  }
}
