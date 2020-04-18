import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facultyfci/models/user.dart';
import 'package:facultyfci/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

//An enumeration is used for defining named constant values. An enumerated type is declared using the enum status users.
enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}


class UserProvider with ChangeNotifier{

  //define rule firebase to store data and status default is Uninitialized
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserService _userService = UserService();
  UserModel _userModel;

  //define function getter to return status, user ad userModel
  Status get status => _status;
  FirebaseUser get user => _user;
  UserModel get userModel => _userModel;


//  make this variables public
  final formKey = GlobalKey<FormState>();
  bool hasStripeId = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }


//A Future is used to represent a potential value, or error, that will be available at some time in the future.
// Receivers of a Future can register callbacks that handle the value or error once it is available.
  //

  //using future with type bool in case sign in to return status user
  Future<bool> signIn()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  //using future with type bool in case sign up to return status user
  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
        _firestore.collection('users').document(result.user.uid).setData({
          'email':email.text,
          'uid':result.user.uid
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //using future with type bool in case sign out to return status user
  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  //function to clear controller which assign to it email and password after sign in and sign up
  void clearController(){
    password.text = "";
    email.text = "";
  }



  //
  Future<void> _onStateChanged(FirebaseUser user) async{

    //if user null ,  user are Status  Unauthenticated
    if(user == null)
    {
      _status = Status.Unauthenticated;
    }
    //else user don't null,
    else
    {
      _user = user;
      _status = Status.Authenticated;
      _userModel = await _userService.getUserById(user.uid);

      if(_userModel.stripeId == null)
      {
        hasStripeId = false;
        notifyListeners();
      }
    }

    //Call all the registered listeners.
    //Call this method whenever the object changes,
    // to notify any clients the object may have.
    // Listeners that are added during this iteration will not be visited.
    // Listeners that are removed during this iteration will not be visited after they are removed.
    notifyListeners();
  }
}