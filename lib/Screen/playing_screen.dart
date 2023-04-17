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

  final AudioPlayer _audioPlayer = AudioPlayer();
  Podcast podcasts=Podcast.podcast[0];

  bool status=false;

  Duration? duration=Duration(seconds: 00);

  void initPlayer()async{
       await _audioPlayer.setAudioSource(AudioSource.asset(podcasts.url));

       duration= await _audioPlayer.duration;
  }

  @override
  void initState(){
    super.initState();
    initPlayer();
  }


  @override
  void dispose() {
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
          Image.asset(
              podcasts.imageurl,
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
                child: Image.asset(podcasts.imageurl,width: 300,),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                podcasts.title,
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
                  child: InkWell(
                    onTap: (){
                      if(status==true){
                        setState(() {
                          status=false;
                        });
                      }
                      else{
                        setState(() {
                          status==true;
                        });
                      }
                    },
                    child: Icon(status? Icons.pause :Icons.play_circle,color: Colors.white,size: 50,),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
