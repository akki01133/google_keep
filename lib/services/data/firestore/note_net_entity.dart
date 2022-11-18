import 'package:json_annotation/json_annotation.dart';

part 'note_net_entity.g.dart';

@JsonSerializable()
class NoteNetEntity{
  int id;
  String title ; //phase 2 - make this nullable
  String note;
  int time;
  int status;
  NoteNetEntity({
    this.id = 0,
    this.title = '',
    this.note = '',
    required this.time,
    required this.status,
  });

  factory NoteNetEntity.fromJson(Map<String,dynamic> json) =>
      _$NoteNetEntityFromJson(json);

  Map<String, dynamic> toJson()=> <String, dynamic>{
    'id': id,
    'title':title,
    'note': note,
    'time': time,
    'status': status,
  };
}
