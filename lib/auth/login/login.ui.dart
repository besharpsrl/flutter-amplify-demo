import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/core/forms/validators/form_validators.dart';
import 'package:flutter_amplify_app/core/ui-builder.dart';
import 'package:flutter_amplify_app/shared/roundedRectButton.dart';
import 'package:flutter_amplify_app/shared/roundedTextFormField.dart';
import 'login.dart';

UiBuilder<LoginState> loginUi = (state) => Container(
  child: Stack(
      children: <Widget>[
        Center(
          child: Column (
              children: [
                Visibility(
                  visible: !state.loggingIn,
                  child: Form(
                    key: state.formKey,
                    child: Column(
                        children: <Widget>[
                          roundedTextFormField(state.usernameController, 'Username', Colors.deepPurple, Colors.white, FormValidators.requiredValidator, false),
                          roundedTextFormField(state.passwordController, 'Password', Colors.deepPurple, Colors.white, FormValidators.passwordValidator, true),
                        ]
                    )
                  ),
                ),
                Visibility(
                  visible: !state.loggingIn,
                  child: roundedRectButton('Let\'s Start', Colors.deepPurple, Colors.white, state.login)
                ),
                Visibility(
                  visible: !state.loggingIn,
                  child:roundedRectButton('Sign Up', Colors.blue, Colors.white, state.register)
                ),
                Visibility(
                  visible: state.loggingIn,
                  child: Align(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        Center(
                          child: Column (
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Text('Login process, please wait...', style: TextStyle(color: Colors.white, fontSize: 20),)
                            ]
                          )
                        )
                      ]
                    ),
                    alignment: FractionalOffset.center,
                  )
                )
              ]
          ),
        )
      ]
  )
);