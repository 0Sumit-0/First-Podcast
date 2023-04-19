import 'package:firebase_auth/firebase_auth.dart';
import 'package:podcast/Modal/UserModel.dart';
import 'package:podcast/Services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance ;

  UserModel? _userFromFirebaseUser(User? user){
    return (user!=null)? UserModel(uid: user.uid): null;
  }

  Stream<UserModel?> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPasswd(String email, String passwd) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: passwd) ;
      User? myuser = result.user;
    UserModel? temp;
    if(myuser!=null){
      temp = UserModel(uid: myuser.uid);
    }
    return temp;
  }catch(e){
  print(e.toString());
  return null;
  }
  }

  Future signInWithEmailAndPasswd(String email, String passwd) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: passwd);
      print("......................................");
      User? myuser = result.user;
      UserModel? temp;
      if(myuser!=null){
        temp = UserModel(uid: myuser.uid);
      }
      print(temp);
      return temp;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}