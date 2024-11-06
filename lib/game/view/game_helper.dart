import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:practicame_app/game/model/game_help.dart';

class GameHelp extends StatefulWidget {
  const GameHelp({required this.gameHelps, super.key});
  final GameHelps gameHelps;

  @override
  State<GameHelp> createState() => _GameHelpState();
}

class _GameHelpState extends State<GameHelp> {
  final _audioPlayer = AudioPlayer();
  final Logger logger = Logger();

  Future<void> _playSound(String source) async {
    try {
      final asset = AssetSource(source);
      await _audioPlayer.play(asset);
    } catch (e) {
      logger.e('Error al reproducir el sonido: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ayuda'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(widget.gameHelps.text),
                  IconButton(
                    onPressed: () async {
                      await _playSound(widget.gameHelps.audios[0]);
                    },
                    icon: const Icon(Icons.volume_up),
                    color: Colors.blueAccent,
                    iconSize: 48,
                    tooltip: 'Reproducir sonido',
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: GameHelperImages(
                      images: widget.gameHelps.images,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          );
        },
      );
    }

    return ElevatedButton.icon(
      onPressed: showMyDialog,
      label: const Text('Ayuda'),
      icon: const Icon(Icons.help),
    );
  }
}

class GameHelperImages extends StatelessWidget {
  const GameHelperImages({required this.images, super.key});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((image) {
        return Image.asset(
          image,
          fit: BoxFit.cover,
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
      ),
    );
  }
}
