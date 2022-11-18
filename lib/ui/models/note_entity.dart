class NoteStatus{
  static const none = 0;
  static const created = 1;
  static const updated = 2;
  static const syncedUpdated = 3;
  static const deleted = 4;
}

class NoteEntity{
  final int id;
  String title ; //phase 2 - make this nullable
  String note;
  int time;
  int status;
  NoteEntity({
    this.id = 0,
    this.title = '',
    this.note = '',
    required this.time,
    required this.status,
  });

  static NoteEntity createFreshNote(){
    int time = DateTime.now().millisecondsSinceEpoch;
    return NoteEntity(status: NoteStatus.created, time: time);
  }
}
