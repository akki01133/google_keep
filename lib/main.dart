import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_machine/providers/google_sign_in.dart';
import 'package:note_machine/providers/multi_note_select_state.dart';
import 'package:note_machine/screens/pages/NotePage.dart';
import 'package:note_machine/services/data/database/object_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  await Firebase.initializeApp();
  runApp(NoteApp());
}

class NoteApp extends StatefulWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xff2d2e32), // navigation bar color
          statusBarIconBrightness: Brightness.light, // status bar icons' color
          systemNavigationBarIconBrightness:
              Brightness.light, //navigation bar icons' color
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<GoogleSignInProvider>(create: (_) => GoogleSignInProvider()),
            ChangeNotifierProvider<MultiNoteSelectProvider>(create: (_) => MultiNoteSelectProvider()),
          ],
          child: GoogleAuthenticatedApp(),
        ),
      ),
    );
  }
}

class GoogleAuthenticatedApp extends StatefulWidget {
  const GoogleAuthenticatedApp({Key? key}) : super(key: key);

  @override
  State<GoogleAuthenticatedApp> createState() => _GoogleAuthenticatedAppState();
}

class _GoogleAuthenticatedAppState extends State<GoogleAuthenticatedApp> {
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    Provider.of<GoogleSignInProvider>(context, listen: false).googleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            setState((){hasError = false;});
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            setState((){hasError = true;});
          }
          if(snapshot.hasData){
            return NotePage();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(hasError) Text('something Went Wrong!!', style: TextStyle(color: Colors.redAccent,fontSize: 18)),
                ElevatedButton(
                    onPressed: ()=>Provider.of<GoogleSignInProvider>(context, listen: false).googleLogin() ,
                    child: Text('Sign In with Google To continue',style: TextStyle(color: Colors.white,fontSize: 20),)
                )
              ],
            ),
          );
        }
      ),
    );
  }

}
