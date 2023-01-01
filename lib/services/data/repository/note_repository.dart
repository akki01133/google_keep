import 'package:note_machine/services/data/database/object_box.dart';
import '../../../screens/models/note_entity.dart';
import '../mapper.dart';

class NotesRepository{
  final ObjectBox objectBox;
  final Mapper mapper = Mapper();

  NotesRepository({required this.objectBox});

  Stream<List<NoteEntity>> getNotesFromDb(){
    final noteDbStream =  objectBox.getNotesFromDb();
    return noteDbStream.map((listNoteDb) => mapper.toNoteEntityListFromDb(listNoteDb).reversed.toList());
  }

  NoteEntity getNoteFromDb(int id){
    final note = objectBox.getNoteFromDb(id);
    if(note == null){
      throw Exception('note with id : ${id}note found');
    }
    return mapper.toNoteEntityFromDb(note);
  }
  int insertNoteInDb(NoteEntity noteEntity) => objectBox.insertNoteInDb(mapper.toNoteDbEntity(noteEntity));
  bool deleteNoteFromDb(int id) => objectBox.deleteNoteFromDb(id);
  int deleteSelectedNotesFromDb(List<int> ids) => objectBox.deleteSelectedNotesFromDb(ids);

  void makeNoteCopy(int id){
    try {
      final note = getNoteFromDb(id);
      final freshNote = NoteEntity.createFreshNote()
        ..title = note.title
        ..note = note.note;
      print('added new copy');
      insertNoteInDb(freshNote);
    }
    catch(err){
      print(err.toString());
    }
  }
}
