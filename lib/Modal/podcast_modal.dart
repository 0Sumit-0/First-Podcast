import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Podcast{
  final String title;
  final String description;
  final String url;
  final String imageurl;
  final String genre;
  String? podid;
  final DocumentReference refusr; //jis user ne create kiya hai uska UID idhar daal de

  Podcast({required this.title,required this.genre , required this.description, required this.url, required this.imageurl, required this.refusr,required podid}){
    final data  = {"title" : this.title, "description": this.description, "url": this.url, "imageurl": this.imageurl, "creator": this.refusr, "genre":this.genre};
    if(podid==null){
      podid = FirebaseFirestore.instance
          .collection("podcasts")
          .add(data)
          .then((documentSnapshot) => (documentSnapshot.id)) as String?;
    }
    else{
      this.podid = podid;
    }
  }

  Future getURL() async{
    final storageRef = FirebaseStorage.instance.ref();
    final podUrl = await storageRef.child(this.url).getDownloadURL();
    return podUrl;
  }

}
