import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../Modal/podcast_modal.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  late final AudioPlayer _audioPlayer;
  // Podcast podcasts=Podcast.podcast[0];

  bool status=false;

  Duration? duration=Duration(seconds: 00);

  @override
  void initState(){
    super.initState();
    _audioPlayer= AudioPlayer();
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
          Image.asset(
              "assets/images/4.jpg",
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
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset("assets/images/4.jpg",width: 300,),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "title",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00:00",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  ),
                  Slider.adaptive(min:0,max:duration!.inSeconds.toDouble(),value: 0, onChanged: (value){},activeColor: Colors.white,),
                  Text(
                    "${duration!.inMinutes}:${duration!.inSeconds % 60}",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  child: IconButton(
                    icon:Icon(status? Icons.pause :Icons.play_circle,size: 60,),
                    color: Colors.white,
                    onPressed: (){
                      myaudioplayer(_audioPlayer).load("assets/audio/test_song.mp3");
                      if(status==true){
                        setState(() {
                          myaudioplayer(_audioPlayer).pause();
                          status=false;
                          print("tapped yes");
                        });
                      }
                      else{
                        setState(() {
                          myaudioplayer(_audioPlayer).play();
                          status==true;
                        });
                      }
                    },
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



abstract class Podcastplayer {
  // Future<void> init();
  Future<void> load(String url);
  void play();
  void pause();
  void seek(Duration position);
  Stream<Duration> get position;
  Stream<Duration> get totalDuration;
  Future<void> dispose();
}


class myaudioplayer implements Podcastplayer{
  AudioPlayer? audioPlayer;
  myaudioplayer(audioplayer){
    this.audioPlayer=audioplayer;
  }

  // Podcast podcasts= Podcast.podcast[0];

  @override
  Future<Duration> load(String url)async {
    final source=AudioSource.uri(
      Uri.parse(url),
    );
    return await audioPlayer!.setAudioSource(source) ?? Duration.zero;
  }

  @override
  void play() => audioPlayer!.play();

  @override
  void pause() => audioPlayer!.pause();

  @override
  void seek(Duration position) => audioPlayer!.seek(position);

  @override
  Stream <Duration> get position =>audioPlayer!.positionStream;

  @override
  Stream<Duration> get totalDuration => audioPlayer!.durationStream.map(
        (duration) => duration ?? Duration.zero,
  );

  @override
  Future<void> dispose() async => await audioPlayer!.dispose();
}