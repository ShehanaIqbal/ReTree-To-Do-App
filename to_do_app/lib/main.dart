import 'package:flutter/material.dart';

import 'package:todoapp/Pages/about.dart';
import 'package:todoapp/Pages/login.dart';
import 'package:todoapp/Pages/main_content_leaderBoard.dart';
import 'package:todoapp/Pages/main_content_tasks.dart';
import 'package:todoapp/Pages/splashScreen.dart';
import 'package:todoapp/Pages/progressBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
        '/about': (BuildContext context)=> new AboutPage(),
        '/tasks': (BuildContext context)=> new MainContent(),
        '/leaderboard':(BuildContext context)=>new MainContentLeaderboard(),
        '/pro':(BuildContext context)=>new ProgressBar(),
      },
    );
  }
}
