import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'amplifyconfiguration.dart';
import 'auth/layouts/login_layout/login_layout.dart';
import 'auth/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Amplify amplifyInstance = Amplify();

  @override
  void initState() {
    // We have an initial state and we configure it
    super.initState();

    // Configure Amplify with needed plugins
    configureAmplify();

    configureDownloader();
  }

  void configureDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
  }

  void configureAmplify() async {
    if (!mounted) return;

    // Add Pinpoint, Cognito and S3 Plugins: this can be done only once:
    // so a good try catch and we're good
    try {
      AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      AmplifyStorageS3 storage = AmplifyStorageS3();

      amplifyInstance.addPlugin(authPlugins: [authPlugin]);
      amplifyInstance.addPlugin(analyticsPlugins: [analyticsPlugin]);
      amplifyInstance.addPlugin(storagePlugins: [storage]);

      // Once Plugins are added, configure Amplify
      await amplifyInstance.configure(amplifyconfig);
    } catch(e) {
      print('Amplify alrady configured...go on');
    }
  }

  @override
  Widget build(BuildContext context) {

    // Set the correct app orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Entry point for the app design
    return MaterialApp(
      home: LoginLayout(child: Login(),),
      theme: ThemeData(accentColor: Colors.white),
    );
  }
}