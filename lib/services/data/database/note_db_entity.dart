import 'package:objectbox/objectbox.dart';


@Entity()
class NoteDbEntity{
  int id;
  String title ; //phase 2 - make this nullable
  String note;
  int time;
  int status;
  NoteDbEntity({
    this.id = 0,
    this.title = '',
    this.note = '',
    required this.time,
    required this.status,
  });
}
