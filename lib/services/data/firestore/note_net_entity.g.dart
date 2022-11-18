// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_net_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteNetEntity _$NoteNetEntityFromJson(Map<String, dynamic> json) =>
    NoteNetEntity(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      note: json['note'] as String? ?? '',
      time: json['time'] as int,
      status: json['status'] as int,
    );

Map<String, dynamic> _$NoteNetEntityToJson(NoteNetEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'time': instance.time,
      'status': instance.status,
    };
