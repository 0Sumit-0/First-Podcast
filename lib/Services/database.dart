
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('User');
  Future? updateUserData(String name, String desc, String url, String imageurl) async{
    return UserCollection.doc(uid).set({
      'name' : name,
      'description' : desc,
      'url' : url,
      'imageurl' : imageurl
    });
  }

}