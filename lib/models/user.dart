import 'package:cloud_firestore/cloud_firestore.dart';

//here class to define data users that will get on it
class UserModel{
  static const NAME = 'name';
  static const EMAIL = "email";
  static const ID = 'id';
  static const STRIPE_ID = 'stripeId';


// define variables
  String _name;
  String _email;
  String _id;
  String _stripeId;

//  getters  to return data
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

// A DocumentSnapshot contains data read from a document in your Firestore database.
  UserModel.fromSnapshot(DocumentSnapshot snap){   // Contains all the data of this snapshot
    _email = snap.data[EMAIL];
    _name = snap.data[NAME];
    _id = snap.data[ID];
    _stripeId = snap[STRIPE_ID] ?? null;

  }
}