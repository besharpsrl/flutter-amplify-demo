import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/auth/layouts/login_layout/login_layout.dart';
import 'package:flutter_amplify_app/auth/login/login.dart';
import 'package:flutter_amplify_app/shared/toastr.dart';
import 'signup.ui.dart';

// =======================================================
// In this space we can define constants for the dart file
//
// ...
// =======================================================

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignupState(); // new can be omitted in dart...
  }
}

// This class is used to manage Login with Amplify.
// It also contains simple code to navigate to the register page
class SignupState extends State<Signup> {

  // Is registering process in action?
  bool registering = false;

  // Is confirming process in action?
  bool confirming = false;

  // Keep status of signing process as we also need email confirmation
  bool isSignUpComplete = false;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

  // These are the controllers for retrieving text from textfield:
  // basically you attach one of these to the textfield
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmController = new TextEditingController();

  // Create a new user
  signupNewUser() async {

    if (formKey.currentState.validate()) {
      try {
        // Start registering
        setState(() {
          registering = true;
        });

        // Create a map attributes dictionary for holding extra information for the user
        Map<String, dynamic> userAttributes = {
          'email': emailController.text.trim(),
          // additional attributes as needed: we set email because is a common way
          // to define a unique value to use for S3 folders
        };

        // Signup using Amplify with Cognito
        SignUpResult res = await Amplify.Auth.signUp(
            username: usernameController.text.trim(),
            password: passwordController.text.trim(),
            options: CognitoSignUpOptions(
                userAttributes: userAttributes
            )
        );

        // Go on with confirming
        setState(() {
          isSignUpComplete = res.isSignUpComplete;
          registering = false;
        });
      } on AuthError catch (e) {
        toastr('There was a problem signing you up: \n' + e.cause);
      }
    }
  }

  // Before Login we need confirming
  confirmNewUser() async {
    // Be sure to call it only when needed
    if(this.isSignUpComplete) {
      try {
        // Start confirming
        setState(() {
          confirming = true;
        });

        SignUpResult res = await Amplify.Auth.confirmSignUp(
            username: usernameController.text.trim(),
            confirmationCode: confirmController.text.trim()
        );

        // Tell user that sigup is successful
        toastr('You are now registered! Login with you user and password!');

        // Confirmed - Return home
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginLayout(child: Login())));
        setState(() {
          confirming = false;
        });

      } on AuthError catch (e) {
        toastr('There was a problem confirming you up: \n' + e.cause);
      }
    }
  }

  backToLogin() {
    // Return home
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginLayout(child: Login())));
  }



  // Come ReactNative lo chiama il sistema quando deve disegnare le pagine
  @override
  Widget build(BuildContext context) {
    return this.isSignUpComplete ? confirmUi(this) : signupUi(this);
  }

}