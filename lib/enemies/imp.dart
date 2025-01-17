import 'package:bonfire/bonfire.dart';
import 'package:cloud_explorers/main.dart';
import 'package:cloud_explorers/util/enemy_sprite_sheet.dart';
import 'package:cloud_explorers/util/functions.dart';
import 'package:cloud_explorers/util/game_sprite_sheet.dart';
import 'package:cloud_explorers/util/sounds.dart';
import 'package:flutter/material.dart';

class Imp extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 10;

  Imp(this.initPosition)
      : super(
          animation: EnemySpriteSheet.impAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.8),
          speed: tileSize / 0.30,
          life: 80,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              valueByTileSize(6),
              valueByTileSize(6),
            ),
            align: Vector2(
              valueByTileSize(3),
              valueByTileSize(5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(
      canvas,
      borderRadius: BorderRadius.circular(2),
    );
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.seeAndMoveToPlayer(
      radiusVision: tileSize * 5,
      closePlayer: (player) {
        execAttack();
      },
    );
  }

  void execAttack() {
    this.simpleAttackMelee(
      size: Vector2.all(tileSize * 0.62),
      damage: attack,
      interval: 300,
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: this.position,
        size: Vector2(32, 32),
      ),
    );
    removeFromParent();
    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic id) {
    this.showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(attacker, damage, id);
  }
}
