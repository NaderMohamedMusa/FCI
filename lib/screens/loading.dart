import 'package:flutter/material.dart';


// this page private by loading, so can design form beautiful with loadin, Where it appears to the user unless his data is loaded
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
