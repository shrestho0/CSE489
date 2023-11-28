import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // Google Sign in
  signInWithGoogle() async {
    // begin signin process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // auth data
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create cred
    final cred = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    try {
      UserCredential x = await FirebaseAuth.instance.signInWithCredential(cred);
      return [true, x];
    } catch (e) {
      print("services/auth_services:signInWithGoogle: ${e.toString()}");

      return [false, e.toString()];
    }
  }

  /// signInWithPassword
  /// returns [bool success. String message]
  signInWithPassword({required String email, required password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("services/auth_services:signInWithPassword: success");
      return [true, ""];
    } on FirebaseAuthException catch (e) {
      print("services/auth_services:signInWithPassword: ${e.toString()}");
      if (e.code == 'user-not-found') {
        return [false, "User not found."];
      } else if (e.code == 'wrong-password') {
        return [false, "Wrong password provided for that user."];
      } else if (e.code == "channel-error") {
        return [false, "Channel error"];
      } else {
        return [false, e.code];
      }
    } catch (e) {
      print("services/auth_services:signInWithPassword: ${e.toString()}");
      return [false, "Unknown Error. Could not catch"];

      // fuck it
    }
  }

  ///

  signUpWithPassword({required String email, required password}) async {
    print("account khola hobe");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("services/auth_services:signInWithPassword: success");
      return [true, ""];
    } on FirebaseAuthException catch (e) {
      print("services/auth_services:signInWithPassword: ${e.toString()}");

      return [false, e.code];
    } catch (e) {
      print("services/auth_services:signInWithPassword: ${e.toString()}");
      return [false, "Unknown Error. Could not catch"];

      // fuck it
    }
  }
}
