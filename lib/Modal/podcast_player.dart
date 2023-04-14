import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PodcastPlayer extends StatefulWidget {
  final String podcastUrl;

  PodcastPlayer({required this.podcastUrl});

  @override
  _PodcastPlayerState createState() => _PodcastPlayerState();
}

class _PodcastPlayerState extends State<PodcastPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadPodcast();
  }

  Future<void> _loadPodcast() async {
    await _audioPlayer.setUrl(widget.podcastUrl);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Podcast Player'),
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.play();
          },
          child: Text('Play'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _audioPlayer.pause();
          },
          child: Text('Pause'),
        ),
      ],
    );
  }
}
