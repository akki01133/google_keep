import 'package:flutter/material.dart';

import '../models/note_entity.dart';

Widget editNotePage({required context,required NoteEntity noteEntity })
    {
      final titleController = TextEditingController();
      final noteController = TextEditingController();
      titleController.text = noteEntity.title;
      noteController.text = noteEntity.note;

      noteStatus(int status) {
        return NoteStatus.created;
      }

      Widget editPageAppBar(){
        return Container(
          padding: EdgeInsets.only(top: 10, bottom: 8, left: 2, right: 2),
            child: Row(
              children: [
                Expanded(child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop(
                          NoteEntity(
                              id: noteEntity.id,
                              status: noteStatus(noteEntity.status),
                              title: titleController.text,
                              time: DateTime.now().millisecondsSinceEpoch,
                              note: noteController.text,
                          ));},
                    icon: Icon(Icons.arrow_back_outlined, size: 24, color: Colors.grey[400]),
                  ),
                )),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.pin_drop_outlined, size: 23, color: Colors.grey[400]),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.notification_add, size: 23, color: Colors.grey[400]),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.archive_outlined, size: 23, color: Colors.grey[400]),
                    ),
                  ],
                )
              ],
            ),
        );
      }


      Widget editNoteBody(){
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Column(
            children: [
              TextField(
                controller:  titleController,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[300],
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white54,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  )
                ),
              ),

              TextField(
                controller: noteController,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[300],
                ),
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white54,
                maxLines: null,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )
                ),
              ),
            ],
          ),
        );
      }

      Widget bottomBar(){
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined, size: 22, color: Colors.grey,), splashRadius: 25,),
                        IconButton(onPressed: (){}, icon: Icon(Icons.color_lens_outlined, size: 22, color: Colors.grey,))
                      ],
                    ),
              ),

              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.undo, size: 22, color: Colors.grey,))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.redo, size: 22, color: Colors.grey,)))
                      ],
                    ),

              ),
              Expanded(
                  flex: 1,
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 22, color: Colors.grey,))),
                      ],
                    ),
              ),
            ],
          ),
        );
      }
      return Container(
        color: Color(0xff2B2C2E),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xff1f1f1f),
            body: Column(
              children: [
                editPageAppBar(),
                Expanded(flex: 1, child: editNoteBody()),
                bottomBar(),
              ],
            ),
          ),
        ),
      );


    }
