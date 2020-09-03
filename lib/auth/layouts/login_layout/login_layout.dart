import 'package:flutter/material.dart';

class LoginLayout extends StatefulWidget {

  final Widget child;

  LoginLayout({
    this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return LoginLayoutState();
  }

}

class LoginLayoutState extends State<LoginLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color.fromARGB(255, 112, 7, 97),
              Color.fromARGB(255, 24, 7, 51),
              Color.fromARGB(255, 28, 30, 78),
              Color.fromARGB(255, 16, 71, 128),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: SingleChildScrollView(
              child: Center(
                child: Column (
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top:100, left: 50, right: 50, bottom: 0),
                          child: Image(image: AssetImage("assets/images/logo.png"), fit: BoxFit.cover, color: Colors.white,)
                      ),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Text('S3 Dropbox demo - Login or register to use the app!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      ),
                      this.widget.child
                    ]
                )
              ),
            ),
        )
    );
  }
}