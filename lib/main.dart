import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_machine/providers/google_sign_in.dart';
import 'package:note_machine/providers/multi_note_select_state.dart';
import 'package:note_machine/services/data/database/object_box.dart';
import 'package:note_machine/ui/pages/NotePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  await Firebase.initializeApp();
  runApp(NoteMachine());
}

class NoteMachine extends StatefulWidget {
  const NoteMachine({Key? key}) : super(key: key);

  @override
  State<NoteMachine> createState() => _NoteMachineState();
}

class _NoteMachineState extends State<NoteMachine> {
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
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.googleLogin();
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            setState((){
              hasError = false;
            });
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            setState((){
              hasError = true;
            });
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
                    onPressed: ()=>provider.googleLogin() ,
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
