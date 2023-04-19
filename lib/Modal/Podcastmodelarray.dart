
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Modal/podcast_modal.dart';

class PodModArr{
  String? type; //for selecting all take null
  List<Podcast> lis = [];
  PodModArr({this.type}){
    FirebaseFirestore.instance.collection('podcasts').where(((type!=null)?type:'All') as String, isEqualTo: true).get().then(
        (querySnapshot){
          for (var docSnapshot in querySnapshot.docs){
            Map<String, dynamic> daata = docSnapshot.data();
            lis.add(new Podcast(title: daata['title'],
                genre: daata['genre'],
                description: daata['description'],
                url: daata['url'],
                imageurl: daata['imageurl'],
                refusr: daata['refusr'],
                podid: daata['podid']));
          }
        },
        onError:(e) => print("PODCASTMODELARRAY ERROR!!!!!!!"),
    );
  }
}