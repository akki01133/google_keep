import 'package:flutter/material.dart';

class NoteMenuItem{
  final String title;
  const NoteMenuItem({required this.title});
}

class NoteEditMenu{
  static final List<NoteMenuItem> menuList = [
    archiveOption,
    deleteOption,
    makeCopyOption,
    sendOption,
  ];

  static const archiveOption = NoteMenuItem(title: 'Archive',);
  static const deleteOption = NoteMenuItem(title: 'Delete',);
  static const makeCopyOption = NoteMenuItem(title: 'Make a copy',);
  static const sendOption = NoteMenuItem(title: 'Send',);
}
