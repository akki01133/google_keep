import 'package:flutter/material.dart';
import 'package:note_machine/services/data/repository/note_repository.dart';
import 'package:note_machine/screens/menu/selectModeMenu.dart';
import 'package:provider/provider.dart';

import '../../providers/multi_note_select_state.dart';

class SelectModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final VoidCallback disableSelectModeCallBack;
  final double topHeight;
  final VoidCallback archiveCallBack;
  final NotesRepository notesRepository;

  const SelectModeAppBar({Key? key,
    required this.context,
    required this.notesRepository,
    required this.topHeight,
    required this.disableSelectModeCallBack,
    required this.archiveCallBack,
    }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(62);

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[300];
    final MultiNoteSelectProvider mnsProvider = Provider.of(context, listen: true);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.5),
      margin: EdgeInsets.only(top: topHeight),
      color: Color(0xff2b2c2e),
      child: Row(
        children: [
          IconButton(onPressed:()=> disableSelectModeCallBack(), icon: Icon(Icons.close, size: 24,color: textColor,)),
          Expanded(
              flex: 1,
              child: Text( '${mnsProvider.isNoteSelectedMap.length}', style:  TextStyle(fontSize: 20, color: textColor,))
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.push_pin_outlined, size: 24,color: textColor )),
          IconButton(onPressed: (){}, icon: Icon(Icons.notification_add_outlined, size: 24,color: textColor)),
          IconButton(onPressed: (){}, icon: Icon(Icons.color_lens_outlined, size: 24,color: textColor)),
          IconButton(onPressed: (){}, icon: Icon(Icons.label_outline_sharp, size: 24,color: textColor)),
          PopupMenuButton<NoteMenuItem>(
            color: Color(0xff2b2c2e),
            icon: Icon(Icons.more_vert_rounded, size: 24,color: textColor,),
            onSelected: (menuItem) => onSelectedMenuOption(context, menuItem, mnsProvider.getSelectedNoteIdList()),
            itemBuilder: (context) => mnsProvider.isNoteSelectedMap.length == 1 ? [
            ...NoteEditMenu.menuList.map((item) => buildMenuItem(item)).toList(),
            ] : [
              buildMenuItem(NoteEditMenu.menuList[0]),
              buildMenuItem(NoteEditMenu.menuList[1]),
            ],
          ),
        ],
      ),
    ) ;
  }

  buildMenuItem(NoteMenuItem item) =>PopupMenuItem(
     value: item,
     child:Container(
          padding: EdgeInsets.only(left: 5),
         height: 25,
         width: 120,
         child: Text(item.title, style: TextStyle(fontSize: 18,color: Colors.grey[300]),),)
  );

  void onSelectedMenuOption(
      BuildContext context, menuItem,List<int> ids) async {

    switch (menuItem) {
      case NoteEditMenu.archiveOption:
        disableSelectModeCallBack();
          break;
      case NoteEditMenu.deleteOption:
          notesRepository.deleteSelectedNotesFromDb(ids);
          disableSelectModeCallBack();
          break;
      case NoteEditMenu.makeCopyOption:
          disableSelectModeCallBack();
          notesRepository.makeNoteCopy(ids[0]);
          break;
      case NoteEditMenu.sendOption:
          break;
    }
  }

}
