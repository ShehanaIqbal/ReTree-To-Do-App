import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}
class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {

    return Center(
          child: Text("This feature will be available soon",
          style: TextStyle(fontSize: 18.0,
          fontWeight: FontWeight.w300),)
    );
  }


}