
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../Modal/podcast_modal.dart';

class create extends StatefulWidget {
  final String? userid;

  const create({super.key, this.userid});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  TextEditingController _title=TextEditingController();

  TextEditingController _description=TextEditingController();

  TextEditingController _genre=TextEditingController();

  PlatformFile? pickedFile;
  PlatformFile? pickedFile_image;
  late File fileobject;
  late File imageobject;


  bool _fileSelected=false;
  bool _imageSelected=false;

  Future fileSelect() async{
    final result=await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.custom,allowedExtensions: ['mp3']);
    if(result==null){
      return;
    }else{
      setState(() {
        pickedFile=result.files.first;
        _fileSelected=true;
        fileobject=File(result.files.single.path.toString());
      });
    }
  }

  Future imageSelect() async{
    final result_image=await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.custom,allowedExtensions: ['jpg','png']);
    if(result_image==null){
      return;
    }else{
      setState(() {
        pickedFile_image=result_image.files.first;
        _imageSelected=true;
        imageobject=File(result_image.files.single.path.toString());
      });
    }
  }

  upload(){
    Podcast().makeNew(_title.text, _description.text, imageobject, widget.userid, _genre.text, fileobject);
  }


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
                        controller: _title,
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
                        controller: _description,
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
                        trailing: _fileSelected? Icon(Icons.done):null,
                        subtitle: _fileSelected? Text(pickedFile!.name):null,
                        onTap: fileSelect,
                        onLongPress: ()=>setState(() {
                          pickedFile=null;
                          _fileSelected=false;
                        }),
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
                        trailing: _imageSelected? Icon(Icons.done):null,
                        subtitle: _imageSelected? Text(pickedFile_image!.name):null,
                        onTap: imageSelect,
                        onLongPress: ()=>setState(() {
                          pickedFile_image=null;
                          _imageSelected=false;
                        }),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Genre",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _genre,
                        decoration: InputDecoration(
                          hintText: "Enter Genere",
                          labelText: "Genre",
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
                    ElevatedButton(child: Text("Upload",style: TextStyle(color: Colors.white)),onPressed: upload,),
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
