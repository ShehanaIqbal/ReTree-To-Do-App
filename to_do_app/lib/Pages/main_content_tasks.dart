import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Pages/progressBar.dart';
import 'dart:async';
import 'package:todoapp/Pages/test.dart';
import 'package:todoapp/Pages/main_content_leaderBoard.dart';
import 'package:todoapp/Pages/Event.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainContent extends StatefulWidget {

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State < MainContent> {

  List<Event> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Event>((json) => Event.fromMap(json)).toList();
  }
  Future<List<Event>> fetchProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId');
    try {
      final response = await http.get(
          'http://192.168.8.108:3000/task/' + userId.toString());
      if (response.statusCode == 200) {
        return parseProducts(response.body);
      } else {
        Alert(
          style: AlertStyle(backgroundColor:Colors.white.withOpacity(0.75) ,isCloseButton: false,
            isOverlayTapDismiss: false,titleStyle: TextStyle(
              fontSize: 17.0,fontWeight: FontWeight.w600,
            ),descStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.black45),),
          context: context,
          title: "Error",
          desc: "Network failure",
          buttons: [
            DialogButton(
              color: Colors.transparent,
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.green, fontSize: 20,fontWeight: FontWeight.w500),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        return null;
      }
    }catch (e) {
      Alert(
        style: AlertStyle(backgroundColor:Colors.white.withOpacity(0.75) ,isCloseButton: false,
    isOverlayTapDismiss: false,titleStyle: TextStyle(
    fontSize: 17.0,fontWeight: FontWeight.w600,
    ),descStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.black45),),
        context: context,
        title: "Error",
        desc: "Network failure",
        buttons: [
          DialogButton(
            color: Colors.transparent,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.green, fontSize: 20,fontWeight: FontWeight.w500),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      print(e);
      return null;
    }

  }
   navigateToTasks() {
    Navigator.of(context).pushReplacementNamed('/tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          _mainContent(context),
          Container(height: 35,
              color: Theme.of(context).accentColor)
          ,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height:24),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor.withOpacity(0.20),
            borderRadius: BorderRadius.circular(32.0)
          ),
        child:Padding(
          padding: EdgeInsets.only(left:24.0,right: 24.0,top: 24.0,bottom: 48.0),
          child: Text("Tasks",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
          ),
        ),
        ),
        SizedBox(height:24),
Expanded(child:Events(events: fetchProducts())
        )

      ],
    );
  }
}
