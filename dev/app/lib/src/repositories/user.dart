import 'package:cloud_firestore/cloud_firestore.dart';

/// MIT License
/// by Andrea Buttarelli
/// creato il 04/02/2020

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password, String name}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var id = await getIdUser();
      await Firestore.instance.collection('users').document(id).setData({
        'email': '$email',
        'fullName': '$name',
        'created_at': Timestamp.now()
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getIdUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<bool> changeName({String name}) async {
    bool result = false;
    final currentUser = await _firebaseAuth.currentUser();
    await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .updateData({
      'fullName': '$name',
      'updated_at': Timestamp.now(),
    }).then((value) {
      result = true;
    }).catchError((e) {
      print(e.toString());
      result = false;
    });
    return result;
  }

  Future<bool> changeEmail({String email, String password}) async {
    bool result = false;
    var currentUser = await _firebaseAuth.currentUser();
    await _firebaseAuth.signInWithEmailAndPassword(
        email: currentUser.email, password: password);
    currentUser = await _firebaseAuth.currentUser();
    await currentUser.updateEmail(email).then((data) {
      currentUser.sendEmailVerification().then((value) {
        print("email sended");
      }).catchError((e) {
        print("email not sended: ${e.toString()}");
      });
      result = true;
    }).catchError((e) {
      print(e.toString());
      result = false;
    });

    if (result = true) {
      await Firestore.instance
          .collection('users')
          .document(currentUser.uid)
          .updateData({
        'email': '$email',
        'isEmailVerified': false,
      }).then((value) {
        result = true;
      }).catchError((e) {
        print(e.toString());
        result = false;
      });
    }

    return result;
  }

  Future<bool> changePassword({String email}) async {
    bool result = false;
    final currentUser = await _firebaseAuth.currentUser();
    /*await currentUser.updatePassword(password).then((data) {
      result = true;
    }).catchError((e) {
      print(e.toString());
      result = false;
    });*/

    if (currentUser.email == email) {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        result = true;
      }).catchError((e) {
        print(e.toString());
        result = false;
      });
      return result;
    } else {
      return false;
    }
  }

  Future<void> deleteCurrentUser({String password}) async {
    bool result = false;
    final currentUser = await _firebaseAuth.currentUser();
    await currentUser.delete().then((data) {
      result = true;
    }).catchError((e) {
      print(e.toString());
      result = false;
    });

    return result;
  }

  Future<bool> resetForgotPassword(String email) async {
    bool result = false;
    await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      result = true;
    }).catchError((e) {
      print(e.toString());
      result = false;
    });

    return result;
  }
}
