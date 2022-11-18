import 'package:flutter/material.dart';
import 'package:note_machine/ui/pages/NotePage.dart';
Widget sidebarDrawerWidget(BuildContext context, int index) {
    int selectedIndex = index;

    void onSelectedItem(BuildContext context ,int index){
      popDrawer(context);
      if(index == selectedIndex) return;
      switch(index){
        case 0:
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NotePage() ));
          break;
      }
      selectedIndex = index;
    }

    return Drawer(
      child: Material(
        color: Color(0xff2C2C2E),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top+15, bottom: 15,left: 18),
                child: Text('Google Keep', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),)),
            buildMenuItem(title: 'Notes', iconData: Icons.lightbulb_outline_rounded, onClicked:() => onSelectedItem(context, 0)),
            buildMenuItem(title: 'Reminders', iconData: Icons.notifications_none_outlined),
            buildMenuItem(title: 'Create new label', iconData: Icons.add),
            buildMenuItem(title: 'Archive', iconData: Icons.archive_outlined),
            buildMenuItem(title: 'Deleted', iconData: Icons.delete_outline),
            buildMenuItem(title: 'Settings', iconData: Icons.settings_outlined),
            buildMenuItem(title: 'Help & feedback', iconData: Icons.help_outline_outlined),
          ],
        ),
      ),
    );
  }


  void popDrawer(BuildContext context){
   Navigator.of(context).pop();
  }

  Widget buildMenuItem({required String title, required IconData iconData , VoidCallback? onClicked}){
    final color = Colors.grey[300];
    final iconSize = 20.0;
    final fontSize = 16.0;
    return ListTile(
      horizontalTitleGap: 0,
      leading: Icon(iconData, color: color, size: iconSize),
      title: Text(title, style: TextStyle(fontSize: fontSize, color: color, fontWeight: FontWeight.w400),),
      hoverColor: Colors.black12,
      onTap: onClicked,
    );
  }
