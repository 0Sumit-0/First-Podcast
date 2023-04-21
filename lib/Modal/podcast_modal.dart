import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as io;

class Podcast{
  String? title;
  String? description;
  String? genre;
  String? podid;
  String? imageURL;
  String? URL;
  DocumentReference? refusr; //jis user ne create kiya hai uska UID idhar daal de

  Podcast(){
    // final data  = {"title" : this.title, "description": this.description, "url": this.url, "imageurl": this.imageurl, "creator": this.refusr, "genre":this.genre};
    // if(podid==null){
    //   podid = FirebaseFirestore.instance
    //       .collection("podcasts")
    //       .add(data)
    //       .then((documentSnapshot) => (documentSnapshot.id)) as String?;
    // }
    // else{
    //   this.podid = podid;
    // }
  }

  Future makeNew(String? title,  String? description,  io.File imageurl,  String? genre,  DocumentReference? refusr, io.File audioFile) async{
    var collectionRef = FirebaseFirestore.instance.collection('Podcast');
    this.title = title;
    this.description = description;
    this.genre = genre;
    this.refusr = refusr;
    Map<String, dynamic> daataa = {"title":title,  "description":description, "genre":genre,  "refusr":refusr};
    try{
      podid = await collectionRef.add(daataa).then((value) => value.id);
    }catch(e){
      print(e.toString());
    }
    final storageRef = FirebaseStorage.instance.ref().child('Podcast').child("${podid!}.mp3");
    final storageRefImg = FirebaseStorage.instance.ref().child('Image').child("${podid!}.jpg");
    try{
      await storageRef.putFile(audioFile);
      await storageRefImg.putFile(imageurl);
      this.URL = await storageRef.getDownloadURL();
      this.imageURL = await storageRefImg.getDownloadURL();
    }catch(e){
      print(e.toString());
    }
  }

  Future getFromFirebase(String? podid) async{
    this.podid = podid;
    var collection = FirebaseFirestore.instance.collection('Podcast');
    var docSnapshot = await collection.doc(podid).get();
    if (docSnapshot.exists){
      Map<String, dynamic>?  daataa = docSnapshot.data();
      title = daataa?["title"];
      description = daataa?["description"];
      genre = daataa?["genre"];
      refusr = daataa?["refusr"];
    }
    final storageRef = FirebaseStorage.instance.ref().child('Podcast').child(podid!);
    final storageRefimg = FirebaseStorage.instance.ref().child('Image').child(podid!);
    try{
      this.URL = await storageRef.getDownloadURL();
      this.imageURL = await storageRefimg.getDownloadURL();
    }catch(e){
      print(e.toString());
    }
  }

}
