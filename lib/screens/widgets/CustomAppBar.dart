import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final double topHeight;
  final VoidCallback callback;
  final VoidCallback googleSignInCallback;

  const CustomAppBar({Key? key,required this.user, required this.topHeight, required this.callback, required this.googleSignInCallback}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 5,
        right: 10,
      ),
      margin: EdgeInsets.only(top: topHeight+8, left: 14, right: 14,),
      decoration: BoxDecoration(
          color: Color(0xff2b2c2e), borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: IconButton(
                splashRadius: 18,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 24,
                  color: Colors.grey[400],
                )),
          ),
          Expanded(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
              child:
               Container(
                 height: 48,
                 padding: EdgeInsets.only(left:10),
                 child: Row(
                   children:[
                     Text(
                     'Search your notes',
                      textAlign: TextAlign.start,
                     style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                   ),]
                 ),
               ),
                ),
              ),),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  Icons.grid_view,
                  size: 26,
                  color: Colors.grey[400],
                )),
          ),

          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child:  IconButton(
              onPressed: googleSignInCallback,
              splashRadius: 20,
              icon: Container(
                  height: 35,
                  width: 35 ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                      image: DecorationImage(
                          image: NetworkImage(user.photoURL!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.darken))),
                  alignment: Alignment.center,
              ),
            ),
          )
      ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.redAccent),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    List<Widget> x = query != ''
        ? [
            IconButton(
                onPressed: () {
                  query = '';
                },
                icon: Icon(Icons.clear))
          ]
        : [];
    return x;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
