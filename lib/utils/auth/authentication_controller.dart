import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plant_classification/model/user.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth _firebaseAuth;
  final storage = GetStorage();
  final modelUser = ModelUser(username: "", imgIndex: 0).obs;

  AuthenticationController(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => loadUser(value.user!.uid));
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  void loadUser(String uid) {
    modelUser(ModelUser(
      uid: uid,
      username: storage.read('username'),
      imgIndex: storage.read('usrImage'),
    ));
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => loadUser(value.user!.uid));
      return "";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    modelUser(ModelUser(uid: "", username: "", imgIndex: 0));
  }
}
