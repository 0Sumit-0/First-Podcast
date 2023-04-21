
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Modal/podcast_modal.dart';

class PodModArr{
  PodModArr();

  Future<List<Podcast>> getArrayOf(String? type) async{
    List<Podcast> array = [];
    if(type!=null){
      FirebaseFirestore.instance.collection('Podcast').where("genre", isEqualTo: type).snapshots().listen((data){
        for (var element in data.docs) {
          Podcast temp = Podcast();
          temp.getFromFirebase(element["podid"]);
          array.add(temp);
        }});
    }
    else{
      FirebaseFirestore.instance.collection('Podcast').snapshots().listen((data){
        for (var element in data.docs) {
          Podcast temp = Podcast();
          temp.getFromFirebase(element["podid"]);
          array.add(temp);
        }});
    }
    return array;
  }

}