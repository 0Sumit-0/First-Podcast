import 'dart:ui';

import 'package:flutter/material.dart';

import '../Modal/podcast_modal.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Podcast podcasts=Podcast.podcast[0];

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
            "assets/images/5.jpg",
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 350,
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.white,),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.account_circle),
                              iconColor: Colors.white
                          ),
                        ),
                      ],
                    ),
                    color: Colors.white54,
                  ),
                ),
                Icon(Icons.g_mobiledata,color: Colors.white,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
