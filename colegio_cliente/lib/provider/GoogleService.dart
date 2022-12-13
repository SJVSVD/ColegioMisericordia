import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';

class GoogleServicio {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      ;
      if (googleUser != null) {
        final GoogleSignInAuthentication GoogleAuth =
            await googleUser.authentication;

        final Credential = GoogleAuthProvider.credential(
            accessToken: GoogleAuth.accessToken, idToken: GoogleAuth.idToken);

        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(Credential);
        return userCredential.user;
      } else {
        return null;
      }
    } on PlatformException catch (e) {}
  }

  Future SingOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
