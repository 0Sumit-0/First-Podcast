
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Modal/podcast_modal.dart';

class PodModArr{
  PodModArr();

  List<Podcast> getArrayOf(String? type) {
    List<Podcast> array = [];
    if(type!=null){
      print("Nonoenoenoenoenoenoenoeno---------sdfjnwdofnowe");
      FirebaseFirestore.instance.collection('Podcast').where("genre", isEqualTo: type).snapshots().listen((data) async {
        var totlen = data.docs.length;
        for (var element in data.docs) {
          // print("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
          Podcast temp = Podcast();
          await temp.getFromFirebase(element.id.toString());
          array.add(temp);
          print(array.length);
          print(array);
          if(array.length==totlen){
            break;
          }
        }});
    }
    else{
      print("Nonoenoenoenoenoenoenoeno---------sdfjnwdofnowe");
      FirebaseFirestore.instance.collection('Podcast').where('genre', isNotEqualTo: "Don't Use this").snapshots().listen((data) async {
        for (var element in data.docs) {
          var totlen = data.docs.length;
          print("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
          Podcast temp = Podcast();
          await temp.getFromFirebase(element.id.toString());
          array.add(temp);
          print(array.length);
          print(array);
          if(array.length==totlen){
            break;
          }
        }});
    }
    print(array);
    return array;
  }

}