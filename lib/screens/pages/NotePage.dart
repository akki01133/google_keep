import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_machine/providers/multi_note_select_state.dart';
import 'package:note_machine/services/data/repository/note_repository.dart';
import 'package:provider/provider.dart';
import '../../providers/google_sign_in.dart';
import '../models/note_entity.dart';
import '../widgets/BottomBarWidget.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/NoteTileWidget.dart';
import '../../main.dart';
import '../widgets/SideDrawerWidget.dart';
import '../widgets/selectModeAppBar.dart';
import 'EditNote.dart';


class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NotesRepository notesRepository = NotesRepository(objectBox: objectBox);
  late Stream<List<NoteEntity>> streamNotes;
  late Widget sidebarDrawer;

  @override
  void initState() {
    super.initState();
    streamNotes = notesRepository.getNotesFromDb();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0x24000000)),
    );
  }

  @override
  Widget build(BuildContext context) {
    sidebarDrawer = sidebarDrawerWidget(context, 0);
    return Scaffold(
      backgroundColor: Color(0xff1f1f1f),
      appBar: NoteAppBar(context: context,notesRepository: notesRepository,),
      body: Container(
        margin: EdgeInsets.only( top: 14, left: 10, right: 10, bottom: 0),
        child: StreamBuilder<List<NoteEntity>>(
            stream: streamNotes,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final noteList = snapshot.data!;
              if(noteList.isEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_add, size: 70,color: Colors.white60,),
                      SizedBox.fromSize(size: Size.fromHeight(10),),
                      Text('notes you add will appear here', style: TextStyle(color: Colors.white60, fontSize: 16)),
                      SizedBox.fromSize(size: Size.fromHeight(15),),
                    ],
                  ),
                );
              }
              return Consumer<MultiNoteSelectProvider>(
                builder:(context, mnsProvider, child) =>  ListView.builder(
                  reverse: false,
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    final note = noteList[index];
                    return NoteTileWidget(
                      note: note,
                      onTapCallBack: ()=> onTapNoteTile(context, note, index),
                      onLongPressCallBack: () => onLongPressNoteTile(index, note.id),
                      isSelected: mnsProvider.isNoteSelectedMap[index]!=null ? true :  false,
                      index: index,
                    );
                  },
                ),
              );

            }
        ),
      ),
      drawer: sidebarDrawer,
      bottomNavigationBar: bottomBarWidget(context: context, callBack: ()=>_createAndReturnCreatedNote(context)),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  void onLongPressNoteTile(int index, int id) {
    final mnsProvider = Provider.of<MultiNoteSelectProvider>(context, listen: false);
      if(mnsProvider.multiSelectMode == false){
        mnsProvider.enableMultiSelectMode();
        mnsProvider.selectNoteItem(index, id);
      }
  }

  void onTapNoteTile(context, note, index){
    final mnsProvider = Provider.of<MultiNoteSelectProvider>(context, listen: false);
    if(mnsProvider.multiSelectMode == false){
        editAndReturnEditedNote(context, note, index);
        return;
      }
      if(mnsProvider.isNoteSelectedMap.length == 1 && mnsProvider.isNoteSelectedMap[index] != null){
        mnsProvider.disableMultiSelectedMode();
        return;
      }
      mnsProvider.selectNoteItem(index, note.id);
  }

  Future<void> _createAndReturnCreatedNote(BuildContext context)async {
    NoteEntity freshNote = NoteEntity.createFreshNote();
    freshNote = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => editNotePage(context: context, noteEntity:  freshNote)));

    notesRepository.insertNoteInDb(freshNote);
  }


  Future<void> editAndReturnEditedNote(context , NoteEntity note, index)async {
    note = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => editNotePage(context: context, noteEntity:  note)));
    notesRepository.insertNoteInDb(note);
  }


}

class NoteAppBar extends StatelessWidget with PreferredSizeWidget{
  final BuildContext context;
  final NotesRepository notesRepository;
  const NoteAppBar({Key? key, required this.notesRepository, required this.context}) : super(key: key);
  MultiNoteSelectProvider get  mnsProvider => Provider.of<MultiNoteSelectProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return  mnsProvider.multiSelectMode ? SelectModeAppBar(
        context: context,
        notesRepository: notesRepository,
        topHeight: MediaQuery.of(context).viewPadding.top,
        disableSelectModeCallBack: mnsProvider.disableMultiSelectedMode,
        archiveCallBack: (){},
      ) : CustomAppBar(topHeight: MediaQuery.of(context).viewPadding.top, callback: mnsProvider.disableMultiSelectedMode, user: FirebaseAuth.instance.currentUser!, googleSignInCallback: Provider.of<GoogleSignInProvider>(context, listen: false).googleLogin);
  }

  @override
  Size get preferredSize =>mnsProvider.multiSelectMode ? Size.fromHeight(62) : Size.fromHeight(55);
}
