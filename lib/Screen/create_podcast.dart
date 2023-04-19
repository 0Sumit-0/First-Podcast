import 'dart:ui';

import 'package:flutter/material.dart';

class create extends StatelessWidget {
  const create({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/2.jpg",
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
                    1,
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
          TextFormField(
            decoration: InputDecoration(),
          ),
        ],
      ),
    );
  }
}
