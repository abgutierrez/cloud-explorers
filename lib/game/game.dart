import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:cloud_explorers/decoration/door.dart';
import 'package:cloud_explorers/decoration/key.dart';
import 'package:cloud_explorers/decoration/potion_life.dart';
import 'package:cloud_explorers/decoration/spikes.dart';
import 'package:cloud_explorers/decoration/torch.dart';
import 'package:cloud_explorers/interface/knight_interface.dart';
import 'package:cloud_explorers/main.dart';
<<<<<<< Updated upstream
import 'package:cloud_explorers/player/local_player/local_player.dart';
import 'package:cloud_explorers/player/remote_player/remote_player.dart';
import 'package:cloud_explorers/player/remote_player/wizard_npc.dart';
import 'package:cloud_explorers/player/knight.dart';
import 'package:cloud_explorers/socket/socket_manager.dart';
import 'package:cloud_explorers/util/dialogs.dart';
import 'package:cloud_explorers/util/player_sprite_sheet.dart';
=======
import 'package:cloud_explorers/npc/remote_player.dart';
import 'package:cloud_explorers/npc/wizard_npc.dart';
import 'package:cloud_explorers/player/knight.dart';
import 'package:cloud_explorers/socket/socket_manager.dart';
import 'package:cloud_explorers/util/dialogs.dart';
>>>>>>> Stashed changes
import 'package:cloud_explorers/util/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  static bool useJoystick = true;
<<<<<<< Updated upstream
  final int idCharacter;
  final int playerId;
  final String nick;
  final Vector2 position;
  final List<dynamic> playersOn;

  const Game({
    Key? key,
    required this.idCharacter,
    required this.position,
    required this.playerId,
    required this.nick,
    required this.playersOn,
  }) : super(key: key);
=======
  const Game({Key? key}) : super(key: key);
>>>>>>> Stashed changes

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  bool showGameOver = false;

  late GameController _controller;
  late SocketManager _socketManager;
  bool firstUpdate = false;
  @override
  void initState() {
    _controller = GameController()..addListener(this);
    _socketManager = BonfireInjector.instance.get();
    Sounds.playBackgroundSound();
<<<<<<< Updated upstream
    _setupSocketControl();
=======
>>>>>>> Stashed changes
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    tileSize = max(sizeScreen.height, sizeScreen.width) / 15;

    var joystick = Joystick(
      directional: JoystickDirectional(
        spriteBackgroundDirectional: Sprite.load('joystick_background.png'),
        spriteKnobDirectional: Sprite.load('joystick_knob.png'),
        size: 100,
        isFixed: false,
      ),
      actions: [
        JoystickAction(
          actionId: 0,
          sprite: Sprite.load('joystick_atack.png'),
          spritePressed: Sprite.load('joystick_atack_selected.png'),
          size: 80,
          margin: EdgeInsets.only(bottom: 50, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('joystick_atack_range.png'),
          spritePressed: Sprite.load('joystick_atack_range_selected.png'),
          size: 50,
          margin: EdgeInsets.only(bottom: 50, right: 160),
        )
      ],
    );
    if (!Game.useJoystick) {
      joystick = Joystick(
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
          acceptedKeys: [
            LogicalKeyboardKey.space,
            LogicalKeyboardKey.keyZ,
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        gameController: _controller,
        joystick: joystick,
<<<<<<< Updated upstream
        player: LocalPlayer(
            widget.playerId, widget.nick, Vector2(2 * tileSize, 3 * tileSize)),
=======
        player: Knight(
          Vector2(2 * tileSize, 3 * tileSize),
        ),
>>>>>>> Stashed changes
        map: WorldMapByTiled(
          'tiled/map.json',
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'door': (p) => Door(p.position, p.size),
            'torch': (p) => AzureLogo(p.position),
            'potion': (p) => PotionLife(p.position, 30),
            'wizard': (p) => WizardNPC(p.position),
            'spikes': (p) => Spikes(p.position),
            'key': (p) => DoorKey(p.position),
            'imp': (p) => Imp(p.position),
            'torch_empty': (p) => Torch(p.position, empty: true),
          },
        ),
        interface: KnightInterface(),
        lightingColorGame: Colors.black.withOpacity(0.6),
        background: BackgroundColorGame(Colors.grey[900]!),
        progress: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Normal',
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Game()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player?.isDead == true) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
<<<<<<< Updated upstream

  void _setupSocketControl() {
    _socketManager.listen('message', (data) {
      if (data['action'] == 'PLAYER_JOIN' &&
          data['data']['id'] != widget.playerId) {
        _addRemotePlayer(data['data']);
      }
    });
  }

  void _addRemotePlayer(Map data) {
    Vector2 personPosition = Vector2(
      double.parse(data['position']['x'].toString()) * tileSize,
      double.parse(data['position']['y'].toString()) * tileSize,
    );

    var enemy = RemotePlayer(data['id'], data['nick'], personPosition);
    if (data['life'] != null) {
      enemy.update(double.tryParse(data['life'].toString()) ?? 0.0);
    }
    _controller.addGameComponent(enemy);
    _controller.addGameComponent(
      AnimatedObjectOnce(
        animation: PlayerSpriteSheet.attackEffectBottom(),
        size: Vector2.all(tileSize),
        position: Vector2(
          personPosition.x,
          personPosition.y,
        ),
      ),
    );
  }
=======
>>>>>>> Stashed changes
}
