import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Design/AppColors.dart';
import '../Design/AppDimensions.dart';

class NikusLogin {
  AppColors appColors;
  AppDimensions appDimensions;
  int shape;

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _user;

  NikusLogin({this.shape});

  getUser() => _user;

  // TODO: onSuccess promise/closure!!
  Widget getGoogleLoginButton({String text, String imagePath, Function onSuccess}) {
    return getLoginButton(text, imagePath, _loginWithGoogle, onSuccess);
  }

  Widget getFacebookLoginButton(String text, String imagePath, Function onSuccess) {
    return getLoginButton(text, imagePath, _loginWithFacebook, onSuccess);
  }

  Widget getMailLoginButton(String text, String imagePath, Function onSuccess) {
    return getLoginButton(text, imagePath, _loginWithFirebase, onSuccess);
  }

  Widget getLoginButton(String text, String imagePath, Function onPressed, Function onSuccess) {
    switch (shape) {
      case 1:
        return null;
      case 2:
        return OutlineButton(
          splashColor: Colors.grey,
          onPressed: () => onPressed(onSuccess),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage(imagePath), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      case 3:
        return null;
    }
  }

  Future<void> _loginWithGoogle(Function onSuccess) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication auth = await googleUser.authentication;

      AuthCredential credential =
          GoogleAuthProvider.getCredential(idToken: auth.idToken, accessToken: auth.accessToken);
      AuthResult result = await _auth.signInWithCredential(credential);

      FirebaseUser user = await _login(result.user).then((usr) => onSuccess(usr));

      this._user = user;
    } catch (e) {
      print("#GOOGLE SIGN IN ERROR: $e");
    }
  }

  logoutGoogle() async {
    await _googleSignIn.signOut();
    print('user signed out');
  }

  _loginWithFacebook(Function onSuccess) {}

  logoutFacebook() {}

  _loginWithFirebase(Function onSuccess) {}

  logout() {}

  Future<FirebaseUser> _login(FirebaseUser user) async {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    return user;
  }

//  // google, facebook, mail, phone
//  Widget getLoginForm(List<String> authServices) {
//    List<Widget> loginMask = List<Widget>();
//    authServices.forEach((authService) {
//      switch (authService) {
//        case "google":
//          loginMask.add(getGoogleLoginButton());
//          break;
//        case "facebook":
//          loginMask.add(getFacebookLoginButton());
//          break;
//        case "mail":
//          loginMask.add(getMailLoginButton());
//          break;
//        case "phone": // EXPERI(MENTAL)!!!
//          return;
//        default:
//          return;
//      }
//    });
//    return Container(
//        child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: loginMask,
//    ));
//  }
}
