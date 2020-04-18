import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facultyfci/models/user.dart';

class UserService{
  String collection = "users";     //Users are saved under this name
  Firestore _firestore = Firestore.instance;  //define firestore


  //function to create users
  void createUser(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).setData(values);
  }

  //function to update informations
  void updateDetails(Map<String, dynamic> values){
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  //Futures can have more than one callback-pair registered. Each successor is treated independently and is handled as if it was the only successor.
  //is inherits from UserModel
  //using inherits to get data the user by using id
  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc)
      {
        return UserModel.fromSnapshot(doc);
      });
}