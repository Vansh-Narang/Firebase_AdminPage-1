import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signIn(String emailAddress, String posController, String name1) async {
    try {
      UserCredential usercredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailAddress, password: posController);
      print(emailAddress);
      print(posController);
      print(name1);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
