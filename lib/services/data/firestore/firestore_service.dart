import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_machine/ui/models/note_entity.dart';

import 'note_net_entity.dart';

class FirebaseException implements Exception{
  final String message;

  FirebaseException({required this.message});

  @override
  String toString()=> 'error while task -\n $message';
}

class FireStoreService{
  final String uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference notePageCollection;

  FireStoreService( {required this.uid}){
    notePageCollection = firestore.collection('UserData').doc(uid).collection('NotePageList');
  }

  Stream<QuerySnapshot> get mainNotes {
    return notePageCollection.snapshots();
  }

  Future<List<NoteEntity>> getNoteList() async{
    List<NoteEntity> response = <NoteEntity>[];
    await notePageCollection.get().then((value){
      response = value.docs.map((entity) => NoteEntity(id: entity['id'], title: entity['title'], status: 0, time: entity['time'])).toList();
    });
    return response;
  }

  Future<void> pushNote(NoteNetEntity entity) async{
    try{
      await notePageCollection.doc('${entity.id}').set(entity.toJson());
    }
    on Exception catch (_, e){
      throw FirebaseException(message: e.toString());
    }
  }

  Future updateNote(NoteNetEntity entity) async{
    await notePageCollection.doc('${entity.id}').update(entity.toJson());
  }

  Future deleteNote(int docId) async{
    await notePageCollection.doc('$docId').delete();
  }

}
