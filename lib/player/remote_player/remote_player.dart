import 'package:bonfire/bonfire.dart';
import 'package:cloud_explorers/main.dart';
<<<<<<< Updated upstream
import 'package:cloud_explorers/player/remote_player/remote_player_controller.dart';
=======
import 'package:cloud_explorers/npc/remote_player_controller.dart';
>>>>>>> Stashed changes
import 'package:cloud_explorers/util/npc_sprite_sheet.dart';
import 'package:cloud_explorers/util/player_sprite_sheet.dart';
import 'package:flutter/material.dart';

class RemotePlayer extends SimpleEnemy
    with
        UseStateController<RemotePlayerController>,
        ObjectCollision,
        UseBarLife {
  final int id;
  final String nick;
  late TextPaint _textConfig;
  Vector2 sizeTextNick = Vector2.zero();

  RemotePlayer(this.id, this.nick, Vector2 initPosition)
      : super(
          animation: PlayerSpriteSheet.playerAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 1.5),
          life: 100,
          speed: tileSize * 3,
        ) {
    _textConfig = TextPaint(
      style: TextStyle(
        fontSize: tileSize / 3,
        color: Colors.white,
      ),
    );
    sizeTextNick = _textConfig.measureText(nick);
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2((tileSize * 0.5), (tileSize * 0.5)),
            align: Vector2((tileSize * 0.9) / 2, tileSize),
          ),
        ],
      ),
    );

    setupBarLife(
      size: Vector2(width * 1.5, size.y * 0.1),
      borderWidth: 2,
      borderRadius: BorderRadius.circular(2),
    );
  }

  @override
  void render(Canvas canvas) {
    _renderNickName(canvas);
    super.render(canvas);
  }

  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: PlayerSpriteSheet.attackEffectTop(),
        position: position,
        size: size,
      ),
    );
    gameRef.add(
      GameDecoration.withSprite(
        sprite: Sprite.load('crypt.png'),
        position: Vector2(
          position.x,
          position.y,
        ),
        size: size,
      ),
    );
    removeFromParent();
    super.die();
  }

  void _renderNickName(Canvas canvas) {
    _textConfig.render(
      canvas,
      nick,
      Vector2(
        position.x + ((width - sizeTextNick.x) / 2),
        position.y - sizeTextNick.y - 12,
      ),
    );
  }

  void execAttack(Direction? direction) {
    var anim = NpcSpriteSheet.wizardIdleLeft();
    this.simpleAttackRange(
      id: id,
      animationRight: anim,
      interval: 0,
      direction: direction,
      animationDestroy: NpcSpriteSheet.kidIdleLeft(),
      size: Vector2.all(tileSize * 0.9),
      speed: speed * 3,
      enableDiagonal: false,
      damage: 15,
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize * 0.9, tileSize * 0.9),
          )
        ],
      ),
    );
  }

  @override
  bool checkCanReceiveDamage(AttackFromEnum attacker) {
    return false;
  }

  void execShowDamage(double damage) {
    this.showDamage(
      damage,
      config: TextStyle(color: Colors.red, fontSize: 14),
    );
  }
}
