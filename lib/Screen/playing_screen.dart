import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../Modal/podcast_modal.dart';

class PlayScreen extends StatefulWidget {
  final List<Podcast?>?  pod;  // on switching take any url and list of url to play previous or next.......done for switching.....
  final int index;


  const PlayScreen({super.key, required this.pod, required this.index});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  late AudioPlayer _audioPlayer;
  var currentindex;
  // Podcast podcasts=Podcast.podcast[0];

  Stream <PositionData> get _positionDataStream =>
      CombineLatestStream.combine3(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
            (position , bufferedPosition, duration)=> PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );


  bool status=false;
  bool isliked= false;
  bool isundo  = false;
  bool isselected =false;

  Duration? duration=Duration(seconds: 00);

  @override
  void initState(){
    super.initState();
    _audioPlayer= AudioPlayer()..setUrl(
        // "https://firebasestorage.googleapis.com/v0/b/edshort-2cc20.appspot.com/o/test_song1.mp3?alt=media&token=9f122431-b846-48c5-b213-58f1200ae9a7"
      (widget.pod?[widget.index]?.URL).toString()
    );
    currentindex=widget.index;
  }

  @override
  void dispose(){
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            (widget.pod?[widget.index]?.imageURL).toString(),
            fit: BoxFit.cover,
          ),
          ShaderMask(
              shaderCallback: (rect){
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.0)
                    ],
                stops: [
                  0.1,
                  0.5,
                  1
                ]).createShader(rect);
              },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.deepPurple.shade200,
                    Colors.deepPurple.shade800,
                  ],
                ),
              ),
            ),
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black54,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network((widget.pod?[currentindex]?.imageURL).toString(),width: 300,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                (widget.pod?[currentindex]?.title).toString(),
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot){
                    final positionData= snapshot.data;
                    return SizedBox(
                      width: 330,
                      child: ProgressBar(
                        barHeight: 8,
                        baseBarColor: Colors.grey,
                        bufferedBarColor: Colors.blueGrey,
                        progressBarColor: Colors.white,
                        thumbColor: Colors.white,
                        timeLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        progress: positionData?.position?? Duration.zero,
                        buffered: positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: InkWell(
                      child: Container(
                        child: Icon(Icons.skip_previous_rounded,size: 40,color: Colors.white,),
                      ),
                      onTap: (){
                        setState(() {
                          _audioPlayer.setUrl((widget.pod?[currentindex]?.URL).toString());
                          currentindex=currentindex-1;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Controls(audioPlayer: _audioPlayer),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: InkWell(
                      child: Container(
                        child: Icon(Icons.skip_next_rounded,size: 40,color: Colors.white,),
                      ),
                      onTap: (){
                        setState(() {
                          _audioPlayer.setUrl((widget.pod?[currentindex]?.URL).toString());
                          currentindex=currentindex+1;
                        });
                      },
                    ),
                  ),

                ],
              )

            ],
          ),
        ],
      ),
    );
  }
}


//
// abstract class Podcastplayer {
//   // Future<void> init();
//   Future<void> load(String url);
//   void play();
//   void pause();
//   void seek(Duration position);
//   Stream<Duration> get position;
//   Stream<Duration> get totalDuration;
//   Future<void> dispose();
// }

//
// class myaudioplayer implements Podcastplayer{
//   AudioPlayer? audioPlayer;
//   myaudioplayer(audioplayer){
//     this.audioPlayer=audioplayer;
//   }
//
//   // Podcast podcasts= Podcast.podcast[0];
//
//   @override
//   Future<Duration> load(String url)async {
//     final source=AudioSource.uri(
//       Uri.parse(url),
//     );
//     return await audioPlayer!.setAudioSource(source) ?? Duration.zero;
//   }
//
//   @override
//   void play() => audioPlayer!.play();
//
//   @override
//   void pause() => audioPlayer!.pause();
//
//   @override
//   void seek(Duration position) => audioPlayer!.seek(position);
//
//   @override
//   Stream <Duration> get position =>audioPlayer!.positionStream;
//
//   @override
//   Stream<Duration> get totalDuration => audioPlayer!.durationStream.map(
//         (duration) => duration ?? Duration.zero,
//   );
//
//   @override
//   Future<void> dispose() async => await audioPlayer!.dispose();
// }


class Controls extends StatelessWidget {
  const Controls({
    super.key,
    required this.audioPlayer,
});
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioPlayer.playerStateStream,
        builder: (context,snapshot){
          final playerState = snapshot.data;
          final processingState= playerState?.processingState;
          final playing =playerState?.playing;
          if(!(playing ?? false)){
            return IconButton(
              onPressed: audioPlayer.play,
              iconSize: 60,
              icon: const Icon(Icons.play_circle),
              color: Colors.white,
            );
          }else if (processingState != ProcessingState.completed){
            return  IconButton(
              onPressed: audioPlayer.pause,
              iconSize: 60,
              icon: const Icon(Icons.pause_rounded),
              color: Colors.white,
            );
          }else{
            return const Icon(
              Icons.play_arrow_rounded,
              size: 60,
              color: Colors.white,
            );
          }
        }
    );
  }
}


class PositionData{

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(
      this.position,
      this.bufferedPosition,
      this.duration,
      );

}