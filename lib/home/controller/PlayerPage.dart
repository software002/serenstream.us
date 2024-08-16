import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatelessWidget {
  final String music;
  PlayerPage({required this.music});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerModel(music),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Music Player'),
        ),
        body: PlayerControls(),
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerModel>(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Now playing: ${model.music}'),
            StreamBuilder<Duration>(
              stream: model.player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                return Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: model.duration.inSeconds.toDouble(),
                  onChanged: (double value) {
                    model.seek(Duration(seconds: value.toInt()));
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: model.isPlaying ? null : model.play,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: model.isPlaying ? model.pause : null,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: model.isPlaying || model.isPaused ? model.stop : null,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PlayerModel extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();
  final String music;
  bool isPlaying = false;
  bool isPaused = false;
  Duration duration = Duration.zero;

  PlayerModel(this.music) {
    _init();
  }

  Future<void> _init() async {
    try {
      await player.setAsset('assets/music/$music');
      player.durationStream.listen((d) {
        duration = d ?? Duration.zero;
        notifyListeners();
      });
      player.playerStateStream.listen((state) {
        if (state.playing) {
          isPlaying = true;
          isPaused = false;
        } else {
          isPlaying = false;
          isPaused = state.processingState == ProcessingState.ready;
        }
        notifyListeners();
      });
    } catch (e) {
      print("Error initializing audio: $e");
    }
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
