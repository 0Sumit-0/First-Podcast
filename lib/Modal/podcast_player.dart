// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:podcast/Modal/podcast_modal.dart';
//
// class PodcastPlayer extends StatefulWidget {
//   final String podcastUrl;
//
//   PodcastPlayer({required this.podcastUrl});
//
//   @override
//   _PodcastPlayerState createState() => _PodcastPlayerState();
// }
//
// class _PodcastPlayerState extends State<PodcastPlayer> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Podcast podcasts=Podcast.podcast[0];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPodcast();
//   }
//
//   Future<void> _loadPodcast() async {
//     await _audioPlayer.setUrl(widget.podcastUrl);
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(Build Context context) {
//     return Column();
//   }
// }
