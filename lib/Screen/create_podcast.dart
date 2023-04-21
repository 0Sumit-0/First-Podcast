import 'dart:ui';

import 'package:flutter/material.dart';

class create extends StatelessWidget {
  const create({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Make Podcast",
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 100, 25, 20),
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white70,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Title",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Title",
                          labelText: "Title",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Description",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          labelText: "Description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select File",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    SizedBox(
                      child: ListTile(
                        title: Text("Select File"),
                        leading: Icon(Icons.file_present_rounded),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select Image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    SizedBox(
                      child: ListTile(
                        title: Text("Select Image"),
                        leading: Icon(Icons.image),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Genere",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Genere",
                          labelText: "Genere",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "genere cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(child: Text("Upload",style: TextStyle(color: Colors.white)),onPressed: (){},),
                    SizedBox(height: 25,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
