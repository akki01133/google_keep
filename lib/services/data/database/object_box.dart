import '../../../objectbox.g.dart';
import './note_db_entity.dart';

class ObjectBox{

  late final Store _store;
  late final Box<NoteDbEntity> _noteDbBox;

  ObjectBox._init(this._store){
    _noteDbBox = Box<NoteDbEntity>(_store);
  }

  static Future<ObjectBox> init() async{
    final store = await openStore();

    return ObjectBox._init(store);
  }

  Stream<List<NoteDbEntity>> getNotesFromDb() => _noteDbBox.query().watch(triggerImmediately: true).map((query) =>query.find());
  NoteDbEntity? getNoteFromDb(int id) => _noteDbBox.get(id);
  int insertNoteInDb(NoteDbEntity noteDbEntity) => _noteDbBox.put(noteDbEntity);
  bool deleteNoteFromDb(int id) => _noteDbBox.remove(id);
  int deleteSelectedNotesFromDb(List<int> ids) => _noteDbBox.removeMany(ids);
}
