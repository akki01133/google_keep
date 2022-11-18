import 'package:flutter/material.dart';

import '../../assets/BottomBarPainter.dart';


Widget bottomBarWidget({required BuildContext context, required callBack}) {
  final Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    color: Colors.transparent,
    height: 50,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: Size(size.width, 50),
          painter: BottomBarPainter(),
        ),
        Positioned(
            right: 32.5,
            top: -32,

            child: FloatingActionButton(
              onPressed:()=> callBack(),
              backgroundColor: Color(0xff2d2e32),
              foregroundColor: Colors.yellow,
              elevation: 5,
              highlightElevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child:Icon( Icons.add, size: 38,color: Colors.amber[600]),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                splashRadius: 20,
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_box_outlined,
                    size: 24,
                    color: Colors.grey[300],
                  )),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                  splashRadius: 22,
                  onPressed: () {},
                  icon: Icon(
                    Icons.brush_outlined,
                    size: 24,
                    color: Colors.grey[300],
                  )),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                  splashRadius: 22,
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic_none_outlined,
                    size: 24,
                    color: Colors.grey[300],
                  )),
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                  splashRadius: 22,
                  onPressed: () {},
                  icon: Icon(
                    Icons.image_outlined,
                    size: 24,
                    color: Colors.grey[300],
                  )),
            ),
          ],
        ),
      ]
    ),
  );
}
