import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Services/database.dart';
class UserModel{

  String? Name;
  String? description;
  String? url;
  String? imageurl;
  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('User');
  final String uid;
  UserModel({required this.uid});

  void updateUser(String name, String desc, String url, String imageurl){
    this.url = url;
    this.Name = name;
    this.imageurl = imageurl;
    this.description = desc;
    updateUserData(name, desc, url, imageurl);
  }

  Future? updateUserData(String name, String desc, String url, String imageurl) async{
    return UserCollection.doc(uid).set({
      'name' : name,
      'description' : desc,
      'url' : url,
      'imageurl' : imageurl
    });
  }

}