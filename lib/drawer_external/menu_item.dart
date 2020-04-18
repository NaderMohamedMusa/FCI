import 'package:flutter/material.dart';

//  define element the menu in drawer
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;


  //constructor to elements menu
  const MenuItem({ this.icon, this.title, this.onTap, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.cyan,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26, color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }
}
