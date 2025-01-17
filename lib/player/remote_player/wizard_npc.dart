import 'package:bonfire/bonfire.dart';
import 'package:cloud_explorers/main.dart';
import 'package:cloud_explorers/util/custom_sprite_animation_widget.dart';
import 'package:cloud_explorers/util/localization/strings_location.dart';
import 'package:cloud_explorers/util/npc_sprite_sheet.dart';
import 'package:cloud_explorers/util/player_sprite_sheet.dart';
import 'package:cloud_explorers/util/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WizardNPC extends GameDecoration {
  bool _showConversation = false;
  WizardNPC(
    Vector2 position,
  ) : super.withAnimation(
          animation: NpcSpriteSheet.wizardIdleLeft(),
          position: position,
          size: Vector2(tileSize * 0.8, tileSize),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      this.seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!_showConversation) {
            gameRef.player!.idle();
            _showConversation = true;
            _showEmote(emote: 'emote/emote_interregacao.png');
            _showIntroduction();
          }
        },
        radiusVision: (2 * tileSize),
      );
    }
  }

  void _showEmote({String emote = 'emote/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: SpriteAnimation.load(
          emote,
          SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
          ),
        ),
        target: this,
        positionFromTarget: Vector2(18, -6),
        size: Vector2(32, 32),
      ),
    );
  }

  void _showIntroduction() {
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(text: getString('talk_wizard_1')),
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_player_1'))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_wizard_2'))],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_player_2'))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_wizard_3'))],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.wizardIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      onFinish: () {
        Sounds.interaction();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
