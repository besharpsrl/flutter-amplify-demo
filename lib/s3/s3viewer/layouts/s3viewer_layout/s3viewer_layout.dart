import 'package:flutter/material.dart';
import 'package:flutter_amplify_app/core/core.dart';

class S3ViewerLayout extends StatefulWidget {

  final Widget child;

  S3ViewerLayout({
    this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return S3ViewerLayoutState();
  }

}

class S3ViewerLayoutState extends State<S3ViewerLayout> {
  String currentUser = '';

  @override
  Widget build(BuildContext context) {

    // Being a Future we use then to control the execution from here
    Core.getUser().then((value) => {
      // And then we use setState to call a graphics update
      setState(() {
        currentUser = 'Welcome ' + value.username;
      })
    });

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
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
              automaticallyImplyLeading: false,
              title: Text(currentUser),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    Core.logout(this.context);
                  },
                ),
              ],
          ),
          body: this.widget.child
        )
    );
  }

}