import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:podcast/Services/database.dart';
import 'dart:io' as io;

class UserModel{

  String Name = "Your Name";
  String description = "Bio...";
  String imageurl = "https://firebasestorage.googleapis.com/v0/b/whateverrr-ab6fe.appspot.com/o/user_318-790139.avif?alt=media&token=ade361be-0657-4407-9b56-1def6ff12a35";
  final String uid;
  UserModel({required this.uid});

  Future makeNew() async{
    var collectionRef = FirebaseFirestore.instance.collection('User');
    Map<String, dynamic>? daataa = {'Name' : this.Name, "Description": this.description, 'imageURL' : this.imageurl} ;
    try{
      collectionRef.doc(uid).set(daataa);
    }catch(e){
      print(e.toString());
    }
  }

  //registration ke baad name desc, etc updation ke liye yeh function use karna!!!
  Future updateUserData(String name, String desc, io.File imageFile) async{
    this.Name = name;
    this.description = desc;
    final storageRefImg = FirebaseStorage.instance.ref().child('UserImage').child("$uid.jpg");
    try{
      await storageRefImg.putFile(imageFile);
      imageurl = await storageRefImg.getDownloadURL();
    }catch(e){
      print(e.toString());
    }
    var collectionRef = FirebaseFirestore.instance.collection('User');
    Map<String, dynamic>? daataa = {'Name' : name, "Description": desc, 'imageURL' : imageurl} ;
    try{
      collectionRef.doc(uid).set(daataa);
    }catch(e){
      print(e.toString());
    }
  }

  Future getFromFirebase() async{
    var collection = FirebaseFirestore.instance.collection('User');
    try{
      var docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? daataa = docSnapshot.data();
        this.Name = daataa?["Name"];
        this.description = daataa?["Description"];
        this.imageurl = daataa?["imageURL"];
      }
    }catch(e){
      print("-=--=-=-=-=-"+e.toString());
    }
  }
}