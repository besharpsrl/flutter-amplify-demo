import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/core/forms/validators/form_validators.dart';
import 'package:flutter_amplify_app/core/ui-builder.dart';
import 'package:flutter_amplify_app/shared/roundedRectButton.dart';
import 'package:flutter_amplify_app/shared/roundedTextFormField.dart';
import 'signup.dart';

UiBuilder<SignupState> signupUi = (state) => Container(
    child: Stack(
        children: <Widget>[
          Visibility(
            visible: !state.registering,
            child: Center(
              child: Column (
                  children: [
                    Form(
                        key: state.formKey,
                        child: Column(
                            children: <Widget>[
                              roundedTextFormField(state.emailController, 'Email', Colors.deepPurple, Colors.white, FormValidators.emailValidator, false),
                              roundedTextFormField(state.usernameController, 'Username', Colors.deepPurple, Colors.white, FormValidators.requiredValidator, false),
                              roundedTextFormField(state.passwordController, 'Password', Colors.deepPurple, Colors.white, FormValidators.passwordValidator, true),
                            ]
                        )
                    ),
                    roundedRectButton('Sign me up!', Colors.deepPurple, Colors.white, state.signupNewUser),
                    roundedRectButton('Back to login...', Colors.blue, Colors.white, state.backToLogin)
                  ]
              ),
            )
          ),
          Visibility(
              visible: state.registering,
              child: Align(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                          child: Column (
                              children: <Widget>[
                                CircularProgressIndicator(),
                                Text('Registering process, please wait...', style: TextStyle(color: Colors.white, fontSize: 20),)
                              ]
                          )
                      )
                    ]
                ),
                alignment: FractionalOffset.center,
              )
          )
        ]
    )
);


UiBuilder<SignupState> confirmUi = (state) => Container(
    child: Stack(
        children: <Widget>[
          Visibility(
            visible: !state.confirming,
            child: Center(
              child: Column (
                  children: [
                    Form(
                        key: state.formKey,
                        child: Column(
                            children: <Widget>[
                              roundedTextFormField(state.confirmController, 'Confirm code', Colors.deepPurple, Colors.white, FormValidators.requiredValidator, false),
                            ]
                        )
                    ),
                    roundedRectButton('Confirm me!', Colors.deepPurple, Colors.white, state.confirmNewUser),
                    roundedRectButton('Back to login...', Colors.blue, Colors.white, state.backToLogin)
                  ]
              ),
            )
          ),
          Visibility(
              visible: state.confirming,
              child: Align(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                          child: Column (
                              children: <Widget>[
                                CircularProgressIndicator(),
                                Text('Confirming process, please wait...', style: TextStyle(color: Colors.white, fontSize: 20),)
                              ]
                          )
                      )
                    ]
                ),
                alignment: FractionalOffset.center,
              )
          )
        ]
    )
);