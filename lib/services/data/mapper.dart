import 'package:note_machine/services/data/database/note_db_entity.dart';

import '../../screens/models/note_entity.dart';

class MapperException<From, To> implements Exception{
  final String message;

  MapperException({required this.message});

  @override
  String toString()=> 'Error when converting $From to $To \n $message';
}


class Mapper{
  NoteEntity toNoteEntityFromDb(NoteDbEntity entity){
    try{
      return NoteEntity(id: entity.id, title: entity.title, note: entity.note,time: entity.time, status: entity.status);
    }catch(e){
      throw MapperException<NoteDbEntity, NoteEntity>(message: e.toString());
    }
  }

  List<NoteEntity> toNoteEntityListFromDb(List<NoteDbEntity> entityList){
    try{
      return entityList.map((entity) => NoteEntity(id: entity.id, title: entity.title , note: entity.note, time: entity.time, status: entity.status)).toList();
    }catch(e){
      throw MapperException<NoteDbEntity, NoteEntity>(message: e.toString());
    }
  }

  NoteDbEntity toNoteDbEntity(NoteEntity entity){
    try{
      return NoteDbEntity(id: entity.id, title: entity.title,note: entity.note, status:  entity.status, time: entity.time);
    }catch(e){
      throw MapperException<NoteEntity, NoteDbEntity>(message: e.toString());
    }
  }

}
