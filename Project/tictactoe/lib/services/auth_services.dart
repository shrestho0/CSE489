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

    return await FirebaseAuth.instance.signInWithCredential(cred);
  }
}
