import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MultiNoteSelectProvider extends ChangeNotifier{
  bool multiSelectMode = false;
  HashMap<int, int> isNoteSelectedMap = HashMap();

  void disableMultiSelectedMode(){
     multiSelectMode = false;
     isNoteSelectedMap.clear();
     SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(statusBarColor: Color(0x24000000)),
     );
    notifyListeners();
  }

  void enableMultiSelectMode(){
     multiSelectMode = true;
     SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(statusBarColor: Color(0xff2b2c2e)),
     );
     notifyListeners();
  }

  List<int> getSelectedNoteIdList(){
    final List<int> ids = [];
    isNoteSelectedMap.forEach((key, value) => ids.add(value));
    return ids;
  }

  void selectNoteItem(index, id){
    if(isNoteSelectedMap[index] == null){
       isNoteSelectedMap[index] = id;
       notifyListeners();
       return;
    }
    isNoteSelectedMap.remove(index);
    notifyListeners();
  }
}
