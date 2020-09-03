import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:file_icon/file_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/auth/layouts/login_layout/login_layout.dart';
import 'package:flutter_amplify_app/auth/login/login.dart';
import 'package:flutter_amplify_app/shared/toastr.dart';

class Core {

  // Static method to get the current logged user
  static Future<AuthUser> getUser() async {
    return Amplify.Auth.getCurrentUser();
  }

  // Static method to logout from Amplify
  static logout(context) async {
    try {
      // Sign out
      Amplify.Auth.signOut();
      // Notify the user
      toastr('You have signed out...\nreturning to homepage.');
      // Return home
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginLayout(child: Login())));
    } on AuthError catch (e) {
      toastr(e.cause);
    }
  }

  static Widget typeOfImage(name) {

    String extension = '.' + name.split('.').last;

    if('.jpg, .jpeg, .png, .gif, .psd, .bmp, .tiff'.contains(extension)) { return Icon(Icons.image, color: Colors.blue); }
    return FileIcon(extension);
  }
}