import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Services/database.dart';
class UserModel{

  String? Name;
  String? description;
  String? imageurl;
  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('User');
  final String uid;
  UserModel({required this.uid}){
    updateUser("Your Name", "Bio...", "https://firebasestorage.googleapis.com/v0/b/whateverrr-ab6fe.appspot.com/o/user_318-790139.avif?alt=media&token=ade361be-0657-4407-9b56-1def6ff12a35");
  }

  void updateUser(String name, String desc, String imageurl){
    this.Name = name;
    this.imageurl = imageurl;
    this.description = desc;
    updateUserData(name, desc,  imageurl);
  }

  Future? updateUserData(String name, String desc, String imageurl) async{
    return UserCollection.doc(uid).set({
      'name' : name,
      'description' : desc,
      'imageurl' : imageurl
    });
  }

}