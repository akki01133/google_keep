// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'services/data/database/note_db_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7616452749666942933),
      name: 'NoteDbEntity',
      lastPropertyId: const IdUid(5, 4211883387493933649),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3397567401332683758),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4445878720123971297),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 840025085929726494),
            name: 'note',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8828948872787030578),
            name: 'time',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4211883387493933649),
            name: 'status',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 7616452749666942933),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    NoteDbEntity: EntityDefinition<NoteDbEntity>(
        model: _entities[0],
        toOneRelations: (NoteDbEntity object) => [],
        toManyRelations: (NoteDbEntity object) => {},
        getId: (NoteDbEntity object) => object.id,
        setId: (NoteDbEntity object, int id) {
          object.id = id;
        },
        objectToFB: (NoteDbEntity object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final noteOffset = fbb.writeString(object.note);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, noteOffset);
          fbb.addInt64(3, object.time);
          fbb.addInt64(4, object.status);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = NoteDbEntity(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              note: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              time: const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              status:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [NoteDbEntity] entity fields to define ObjectBox queries.
class NoteDbEntity_ {
  /// see [NoteDbEntity.id]
  static final id =
      QueryIntegerProperty<NoteDbEntity>(_entities[0].properties[0]);

  /// see [NoteDbEntity.title]
  static final title =
      QueryStringProperty<NoteDbEntity>(_entities[0].properties[1]);

  /// see [NoteDbEntity.note]
  static final note =
      QueryStringProperty<NoteDbEntity>(_entities[0].properties[2]);

  /// see [NoteDbEntity.time]
  static final time =
      QueryIntegerProperty<NoteDbEntity>(_entities[0].properties[3]);

  /// see [NoteDbEntity.status]
  static final status =
      QueryIntegerProperty<NoteDbEntity>(_entities[0].properties[4]);
}
