import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:plant_classification/model/user.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _firebaseAuth;
  final modelUser = ModelUser().obs;

  AuthenticationController(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => modelUser(ModelUser(uid: value.user!.uid)));
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => modelUser(ModelUser(uid: value.user!.uid)));
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    modelUser(ModelUser(uid: ""));
  }
}
