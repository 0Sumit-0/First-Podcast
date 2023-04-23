import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:podcast/Modal/UserModel.dart';

class UserPage extends StatefulWidget {
  UserModel? usermod;

  UserPage({super.key,this.usermod});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {


  final String _username="Username" ;

  final String _bio="Podcast Lover and 0avid Listner";

  bool havedata=false;

  userdata(UserModel um){
    if(um!=null){
      havedata=true;
    }else{
      havedata=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //         end: Alignment.centerRight,
      //         colors: [Colors.deepPurple,Colors.purple,Colors.purpleAccent,Colors.deepPurpleAccent])),
      child: RefreshIndicator(
        onRefresh: (){
          return Future.delayed(
              Duration(seconds: 1),
                  (){
                setState(() {

                });
              }
          );
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/user.jpg",
                  fit: BoxFit.cover,
                  height: 300,
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
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                (widget.usermod?.imageurl).toString()),
                          ),
                          SizedBox(height: 16),
                          Text(
                            (widget.usermod?.Name).toString(),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            (widget.usermod?.description).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: (){

                            },
                            child: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Card(
                      color: Colors.white12,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              'Podcast Subscriptions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Replace with actual list of subscribed podcasts
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.22,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return SizedBox(width: 10,);
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height: 135,
                                          width: 180,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/4.jpg",
                                              fit: BoxFit.cover,
                                              color: Colors.black12,
                                              colorBlendMode: BlendMode.overlay,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:22,
                                        width: 170,
                                        height: 40,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white54.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                "Illusion",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(thickness: 1,color: Colors.white,),
                    ),
                    SizedBox(height: 16),
                    Card(
                      color: Colors.white12,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              'Downloaded Episode',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Replace with actual list of subscribed podcasts
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.22,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return SizedBox(width: 10,);
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height: 135,
                                          width: 180,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/4.jpg",
                                              fit: BoxFit.cover,
                                              color: Colors.black12,
                                              colorBlendMode: BlendMode.overlay,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:22,
                                        width: 170,
                                        height: 40,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white54.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                "Episode 1",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(thickness: 1,color: Colors.white,),
                    ),
                    SizedBox(height: 16),
                    Card(
                      color: Colors.white12,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              'Recently Played',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Replace with actual list of subscribed podcasts
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.22,
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return SizedBox(width: 10,);
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height: 135,
                                          width: 180,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              "assets/images/4.jpg",
                                              fit: BoxFit.cover,
                                              color: Colors.black12,
                                              colorBlendMode: BlendMode.overlay,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:22,
                                        width: 170,
                                        height: 40,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white54.withOpacity(0.8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                "Episode 4",
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}