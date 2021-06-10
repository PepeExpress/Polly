import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:plant_classification/model/user.dart';

class FirestoreDB extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> addNewUser() async {
    return users
        .add({'username': 'username', 'imgIndex': 0, 'points': 0})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> syncData(ModelUser user) async {
    DocumentSnapshot currentUserInfo = await users.doc(user.uid).get();
    Map<String, dynamic> data = currentUserInfo.data() as Map<String, dynamic>;
    if (user.username != data['username'] ||
        user.imgIndex != data['imgIndex']) {
      return users
          .doc(user.uid)
          .update({'username': user.username, 'imgIndex': user.imgIndex})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  Future<void> updatePoints(ModelUser user) async {
    print("CIAOOO");
    messaging.getToken().then((value) => print(value));
    return users
        .doc(user.uid)
        .update({'points': user.points})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<QuerySnapshot<Object?>> getLeaderboard() async {
    var leaderboard = users.orderBy('points', descending: true).limit(10).get();
    print(leaderboard);
    return leaderboard;
  }
}
