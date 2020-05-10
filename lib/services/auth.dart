import 'package:bakeryapp/models/user.dart';
import 'package:bakeryapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // FirebaseAuth type object created to be used in this class only
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User obj from user.dart based on firebase user info
  User _userFromFirebaseUser(FirebaseUser user) {
    // return User ID only if user != null
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    // returns user whenever a change in authentication state detected
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      // creates AuthResult obj to return .user attribute as below
      AuthResult result = await _auth.signInAnonymously();

      // creates FirebaseUser obj that stores all user info
      FirebaseUser user = result.user;

      // return User ID only if user != null, created above
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Default name', '$email', 'green', 0.00, [], []);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}