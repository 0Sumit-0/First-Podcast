import 'package:firebase_auth/firebase_auth.dart';
import 'package:podcast/Modal/UserModel.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance ;

  UserModel? _userFromFirebaseUser(User? user){
    return (user!=null)? UserModel(uid: user.uid): null;
  }

  Stream<UserModel?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }
}