import 'package:flutter/material.dart';
import '../pages/EditNote.dart';
import '../models/note_entity.dart';

class NoteTileWidget extends StatelessWidget {
  final NoteEntity note ;
  final VoidCallback onTapCallBack;
  final VoidCallback onLongPressCallBack;
  final int index;
  final bool isSelected;

  const NoteTileWidget(
      {Key? key, required this.note, required this.onTapCallBack, required this.onLongPressCallBack, required this.index, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final normalBoxDecoration = BoxDecoration(
      border: Border.all(color: Color(0xFF777777)),
      borderRadius: BorderRadius.circular(10),
    );

    final selectedBoxDecoration = BoxDecoration(
      border: Border.all(color: Color(0xC3ABD4FC), width: 1.7),
      color: Color(0x30ABD4FC),
      borderRadius: BorderRadius.circular(10),
    );

    return Column(children: [
      InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTapCallBack(),
        onLongPress: () => onLongPressCallBack(),
        child: Container(
            decoration: isSelected ? selectedBoxDecoration: normalBoxDecoration,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    note.note,
                    style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                  ),
                )
              ],
            )),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
