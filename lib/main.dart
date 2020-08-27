import 'package:flutter/material.dart';
import 'package:whatsnext/screens/login_screen.dart';
import 'package:whatsnext/screens/tasks_screen.dart';
import 'package:whatsnext/screens/asstasks_screen.dart';
import 'package:whatsnext/screens/sharedtasks_screen.dart';
import 'package:whatsnext/screens/create_task.dart';
import 'package:whatsnext/screens/edit_task.dart';
import 'package:whatsnext/screens/onetask.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
void main(){ 
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsNext Login UI',
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/tasks': (context) => TaskScreen(),
        '/asstasks': (context) => AssTaskScreen(),
        '/sharedtasks': (context) => SharedTaskScreen(),
        '/create': (context) => CreateTaskScreen(),
        '/edit': (context) => EditTaskScreen(),
        '/delete': (context) => DelTaskScreen()
      }
    );
  }
}