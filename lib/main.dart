import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rwk20/ui/views/home_view.dart';
import 'package:rwk20/ui/views/service_unavailable.dart';

void main() async {
  // runApp(DevicePreview(builder: (context) => MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
              home: Container(
                child: Center(
                  child: Text(
                      "Something Went Wrong!... Could not initialize firebase."),
                ),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              // builder: DevicePreview.appBuilder,
              title: 'Redemption Week Preorder',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              // home: OKToast(child: HomeView()),
              home: OKToast(child: ServiceUnavailable()),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            home: Container(
              child: Center(
                child: Text("Loading..."),
              ),
            ),
          );
        });
  }
}
