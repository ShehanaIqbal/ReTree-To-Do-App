import 'package:flutter/material.dart';
import 'package:todoapp/Pages/main_content_leaderBoard.dart';
import './tasks_page.dart';
import './events_page.dart';

class MainContent extends StatefulWidget {

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {

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
        tooltip: 'Increment',
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
}