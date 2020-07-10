import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todoapp/Pages/main_content_leaderBoard.dart';
import 'package:todoapp/Pages/events_page.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class MainContent extends StatefulWidget {

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  bool _isUploading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: <Widget>[
          _mainContent(context),
          Container(height: 35,
              color: Theme.of(context).accentColor),
                  ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainContentLeaderboard()),
          );
        },
        tooltip: 'Leaderboard',
        child: Icon(Icons.star_half),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            IconButton(
              icon: Icon(Icons.info_outline,color: Theme.of(context).accentColor,size: 25.0,),
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/about');
              },
              tooltip: "About us",
            )
          ],
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height:24),
        Padding(
          padding: EdgeInsets.only(left:24.0,right: 24.0,top: 24.0,bottom: 48.0),
          child: Text("Tasks",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
          ),
        ),
        Expanded(child:EventPage())

      ],
    );
  }
  String getURL() {
    String url = 'http://192.168.8.108:3000/tasks';
    return url;
  }

  Future<Map<String, dynamic>> _uploadCredentials() async {
    print("came");
    print(getURL());
    setState(() {
      _isUploading = true;
    });
    try {
      final response = await http.get(getURL());
      if (response.statusCode == 200) {
        print("200");
        final Map<String, dynamic> tasks = json.decode(response.body);
//        _resetState();
        print(tasks);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventPage(
                  taskList: tasks)
          ),
        );
        return tasks;
      } else {
        print(response.toString());
        print ("null");
        return null;
      }
    } catch (e) {
      print (e);
      return null;
    }
  }
}