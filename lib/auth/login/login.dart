import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/auth/layouts/login_layout/login_layout.dart';
import 'package:flutter_amplify_app/auth/signup/signup.dart';
import 'package:flutter_amplify_app/s3/s3viewer/layouts/s3viewer_layout/s3viewer_layout.dart';
import 'package:flutter_amplify_app/s3/s3viewer/s3viewer.dart';
import 'package:flutter_amplify_app/shared/toastr.dart';
import 'login.ui.dart';

// =======================================================
// In this space we can define constants for the dart file
// ...
// =======================================================

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState(); // new can be omitted in dart...
  }
}

// This class is used to manage Login with Amplify.
// It also contains simple code to navigate to the register page
class LoginState extends State<Login> {

  // Used to change the graphic when login is in place
  bool loggingIn = false;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

  // These are the controllers for retrieving text from textfield:
  // basically you attach one of these to the textfield
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Login using Amplify and Cognito
  login() async {

    // Validate the form with this line...
    if (formKey.currentState.validate()) {

      // Try to login with Amplify
      try {
        // Start login procedure
        setState(() {
          loggingIn = true;
        });

        SignInResult res = await Amplify.Auth.signIn(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        );

        if(res.isSignedIn) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => S3ViewerLayout(child: S3Viewer())));

          // Reset the variable
          setState(() {
            loggingIn = false;
          });
        }
      } on AuthError catch (e) {

        // Show Auth fail message
        toastr('Login failed:\n' + e.cause);
      }
    }
  }

  // Simply go to the Register page
  register() {
    // Go to register page
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginLayout(child: Signup())));
  }

  // Call this when drawing component graphics
  @override
  Widget build(BuildContext context) {
    return loginUi(this);
  }

}