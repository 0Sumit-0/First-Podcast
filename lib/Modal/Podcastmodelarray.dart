
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:podcast/Modal/podcast_modal.dart';

class PodModArr{
  PodModArr();

  Future<List<Podcast>> getArrayOf(String? type) async{
    List<Podcast> array = [];
    if(type!=null){
      print("Nonoenoenoenoenoenoenoeno---------sdfjnwdofnowe");
      FirebaseFirestore.instance.collection('Podcast').where("genre", isEqualTo: type).snapshots().listen((data){
        for (var element in data.docs) {
          print("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
          Podcast temp = Podcast();
          temp.getFromFirebase(element.id);
          array.add(temp);

        }});
    }
    else{
      print("Nonoenoenoenoenoenoenoeno---------sdfjnwdofnowe");
      FirebaseFirestore.instance.collection('Podcast').where('genre', isNotEqualTo: "Don't Use this").snapshots().listen((data){
        for (var element in data.docs) {
          print("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
          Podcast temp = Podcast();
          temp.getFromFirebase(element.id.toString());
          array.add(temp);

        }});
    }
    print(array);
    return array;
  }

}