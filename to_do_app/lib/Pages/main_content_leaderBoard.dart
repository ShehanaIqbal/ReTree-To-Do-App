import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todoapp/Pages/leaderBoard.dart';
import './main_content_tasks.dart';

class MainContentLeaderboard extends StatefulWidget {

  @override
  _MainContentLeaderboardState createState() => _MainContentLeaderboardState();
}

class _MainContentLeaderboardState extends State<MainContentLeaderboard> {

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
            MaterialPageRoute(builder: (context) => MainContent()),
          );
        },
        tooltip: 'Tasks',
        child: Icon(Icons.view_list),
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
              color: Theme.of(context).accentColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(32.0)
          ),
          child:Padding(
            padding: EdgeInsets.only(left:24.0,right: 24.0,top: 24.0,bottom: 48.0),
            child: Text("Leaderboard",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
            ),
          ),
        ),
        SizedBox(height:24),
        Expanded(
    child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : <Widget>[Text("This feature will be available soon",
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)
          ),]
        )
        )
      ],
    );
  }
}