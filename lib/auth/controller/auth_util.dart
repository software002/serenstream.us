import 'package:firebase_auth/firebase_auth.dart';

class AuthUtil {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {

    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<String> handleSignUp(email, password) async {

    User user;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
       user = result.user!;

      return "${user.uid}" ?? "Invalid";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return "Invalid";
    } catch (e) {
      print(e);
      return "Invalid";
    }
  }
}