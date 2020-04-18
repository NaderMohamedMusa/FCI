import 'package:facultyfci/screens/home_screen.dart';
import 'package:facultyfci/provider/user_provider.dart';
import 'package:facultyfci/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatefulWidget {
  @override
  _ScreenSignUpState createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {

  final _Key = GlobalKey<ScaffoldState>();       //key private scaffold To be reached to the things inside,

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);        //define variable user to inherits state user,
    return Scaffold(
      key: _Key,
      appBar: AppBar(
        title: Text(
          "Screen Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:user.status == Status.Authenticating    //here if user status is Authenticating do Loading Until he uploads his data then logs into the main page
          ? Loading()
      // else user status is not Authenticating so show page login, it contain on.....
      //here design page in container to put things.
          : Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: user.email,
              decoration: InputDecoration(hintText: "Email"),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter The Email';
                }
              },
            ),
            SizedBox(height: 25),
            TextFormField(
              controller:user.password,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter The Password';
                }
              },
            ),
            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                  color: Colors.green
              ),
              child: GestureDetector(
                onTap: () async {    // comment like page login here
                  if(!await user.signUp()){
                    return ;  // using any widget to return
                  }
                  user.clearController();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text("REGISTER", style:TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

