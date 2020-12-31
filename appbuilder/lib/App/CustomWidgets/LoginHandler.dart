import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Settings/GlobalSettings.dart';

import '../Design/AppColors.dart';
import '../Design/AppDimensions.dart';

class LoginHandler {
  AppColors appColors;
  AppDimensions appDimensions;
  int shape;

  FirebaseAuth auth;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginHandler(this.auth, {this.shape = 1});

  directLoginGoogle(onSuccess(User user)) {
    _loginWithGoogle(onSuccess);
  }

  OutlineButton getGoogleLoginButton({
    String text = 'Via Google einloggen',
    String imagePath = 'lib/Assets/Login/google_logo.png',
    double length,
    double height,
    Color color,
    Color textColor,
    @required onSuccess(User user),
  }) {
    return getLoginButton(text, imagePath, _loginWithGoogle, onSuccess, length, height, color, textColor);
  }

  OutlineButton getFacebookLoginButton(String text, String imagePath, onSuccess(User user), length, height, color, textColor) {
    return getLoginButton(text, imagePath, _loginWithFacebook, onSuccess, length, height, color, textColor);
  }

  OutlineButton getMailLoginButton(String text, String imagePath, onSuccess(User user), length, height, color, textColor) {
    return getLoginButton(text, imagePath, _loginWithFirebase, onSuccess, length, height, color, textColor);
  }

  OutlineButton getLoginButton(String text, String imagePath, Function onPressed, Function onSuccess, double length, double height, color, textColor) {
    switch (shape) {
      case 1:
        return OutlineButton(
          splashColor: Colors.grey,
          onPressed: () => onPressed(onSuccess),
          highlightElevation: 0,
          borderSide: BorderSide(color: color),
          child: Container(
            width: length,
            height: height,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage(imagePath, package: 'appbuilder'), height: 25.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
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
                Image(image: AssetImage(imagePath, package: 'appbuilder'), height: 35.0),
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
        return OutlineButton();
      default:
        return OutlineButton();
    }
  }

  Future<void> _loginWithGoogle(onSuccess(User user)) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _auth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(idToken: _auth.idToken, accessToken: _auth.accessToken);
      UserCredential result = await auth.signInWithCredential(credential);

      await _login(result.user).then((usr) => onSuccess(usr));
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

  logout() {
    GlobalSettings.logout();
  }

  Future<void> resetPw(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<User> _login(User user) async {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = auth.currentUser;
    assert(user.uid == currentUser.uid);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

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
