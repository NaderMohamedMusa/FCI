import 'package:facultyfci/screens/login_screen.dart';
import 'package:facultyfci/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//here page home at waiting design
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar (title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            ListTile(
              leading: Icon(Icons.exit_to_app),
              title:  Text("Log out"),
              onTap: () {
                user.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                },
            ),
          ],
        ),
      ),
        body: Container(
          color: Color(0xFF000725),
          child: ListView(
            children: <Widget>[
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
              buildCard(context),
             ],
           ),
        ),
    );
  }

  Card buildCard(BuildContext context) {
    return Card(
              color: Colors.grey[300],
              elevation: 10.0,
              child: Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
              ),
            );
  }
}
