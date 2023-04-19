import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcast/Modal/podcast_modal.dart';
import 'package:podcast/Services/database.dart';

class PodDatabaseService{
  final String podid;
  PodDatabaseService({required this.podid});

  final CollectionReference PodCollection = FirebaseFirestore.instance.collection('Podcasts');
  Future? updatePodData(String podname, DocumentReference madeby, int listeners){
    return PodCollection.doc(podid).set({
      'name' : podname,
      'madeby' : madeby,
      'listeners' : listeners
    });
  }
}