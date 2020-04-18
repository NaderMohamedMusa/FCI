import 'dart:async';
import 'package:facultyfci/screens/forget_screen.dart';
import 'package:facultyfci/screens/home_screen.dart';
import 'package:facultyfci/drawer_external/sidebar.dart';
import 'package:facultyfci/provider/user_provider.dart';
import 'package:facultyfci/screens/signup_screen.dart';
import 'package:facultyfci/screens/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  int _state = 0;  // Define this variable in order to control the button from text, animation and appearance circlerprogressIndicator

  final _key = GlobalKey<ScaffoldState>();  //key private scaffold To be reached to the things inside,

  bool _isHidden = true;    //variable ,This is for the case of the password, I mean, I can see it or not

  //The function the eye of the password ,In order for the value change to occur when pressed on it.
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context); //define variable user to inherits state user,
    return Scaffold(
      key: _key,   //Definition of key for scaffold
      body: user.status == Status.Authenticating  //here if user status is Authenticating do Loading Until he uploads his data then logs into the main page
          ? Loading()
      // else user status is not Authenticating so show page login, it contain on.....
      //here design page in stack to put things Over some.
          : Stack(
              children: <Widget>[
                Container(
                  color: Color(0xFF000725),
                  child: ListView(            //put things in listview to move to up when show keybord to write
                    children: <Widget>[

                      // this colum is private design part up Except in it the logo and the text and drawer
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,               //using MediaQuery.of(context).size.width to get on width Any mobile screen.
                            height: MediaQuery.of(context).size.height / 2.5,      //using MediaQuery.of(context).size.height to get on height Any mobile screen.
                            // using decoration to Determine shape design from gradient to colors and borderRadius and shadow.....
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF000725),
                                    Color(0xFFf5851f)
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(90)
                                )
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Spacer(), // to create a box with a specific size and an optional child or another meaning Creates a flexible space to insert into a [Flexible] widget.

                                Align(            //using to Create an alignment widget also conatiner on child.
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/img/fci.png",
                                      width: 80,
                                      height: 80,
                                    )
                                ),

                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Faculty FCI',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),

                                Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),


                      //This lower part to design
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 65),
                        child: Column(
                          children: <Widget>[

                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 55,
                              padding: EdgeInsets.only(
                                  top: 4, left: 16, right: 16, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 5)
                                  ]),
                              child: TextField(      //using textfield to get on text the user will enter it
                                controller: user.email, //by using controller and Assign value to user.email
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Email University',
                                    hintStyle: TextStyle(fontSize: 19)
                                ),
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 55,
                              margin: EdgeInsets.only(top: 32),
                              padding: EdgeInsets.only(
                                  top: 4, left: 16, right: 16, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 5)
                                  ]),
                              child: TextField(
                                controller: user.password,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 19),

                                    // icon Eye by use simple rule if , so it give value true before user pressed on it
                                    // if user don't pressed on it show Icons.visibility_off ,so value it Remaining true
                                    // if pressed on it show Icons.visibility ,Because it has become false ,so using else
                                    suffixIcon: IconButton(
                                        onPressed: _toggleVisibility,
                                        icon: _isHidden
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)
                                    )
                                ),

                                // allow to user see text Except he enters it.
                                obscureText: _isHidden,
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, right: 32),
                                child: InkWell(
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgetPassword()
                                        ));
                                  },
                                ),
                              ),
                            ),

                            Spacer(),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF000725),
                                      Color(0xFFf5851f),
                                      Color(0xFF000725),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)
                                      )
                              ),

                              child: GestureDetector(  //using GestureDetector like button to have case on tap and child to widget
                                onTap: () async {      //When you press on button   //async Meaning synchronizer code in this case
                                  if (!await user.signIn())   //using await to wait Until the data is recorded on me servier 
                                    //if user 
                                  {
                                    return showAlertDialog(context);
                                  }

                                  //using setstate to change on state animation
                                  setState(() {
                                    if (_state == 0) {
                                      animateButton();
                                    }
                                  });
                                  user.clearController();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                                child: Center(
                                  //here child widget button to do animation on it.
                                  child: ButtonloginAnimation(),
                                ),
                              ),
                            ),


                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, right: 32),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScreenSignUp()),
                                    );
                                  },
                                  child: Text(
                                    'Create Acount',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //show drawer in screen login
                SideBar(),
              ],
            ),
    );
  }

  //function to do animation to button login during enter data correct
  void animateButton()
  {
    setState(() {
      _state = 1;
    });

    //give time to show state animation 2
    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }

// create widget to button login to make animation on button by using case change on state and using if to check on it
  Widget ButtonloginAnimation() {
    // at first show text login when state =0
    if (_state == 0) {
      return Text(
        'Login'.toUpperCase(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    }

    // second show CircularProgressIndicator When pressed on button
    else if (_state == 1)
    {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
    //three show icon check after The specified time CircularProgressIndicator
    else
      {
      return Icon(Icons.check, color: Colors.white);
    }
  }

}


// function show AlertDialog
showAlertDialog(BuildContext context) {
  //widget to button ok in AlertDialog to move to screen Login again
  Widget ButtonOK = FlatButton(
    child: Text("OK", style: TextStyle(fontSize: 25)),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      "Error",
      style: TextStyle(fontSize: 25),
    ),
    content: Text(
      "Please Enter Email and Password",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
    // It is the button that appears below
    actions: [
      ButtonOK,
    ],
    elevation: 24.0,
  );

  // show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
      barrierDismissible: false
  );
}
