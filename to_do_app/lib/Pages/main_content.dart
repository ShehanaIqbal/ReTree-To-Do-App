import 'package:flutter/material.dart';
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
          Positioned(
              right:0,
              child:Text ("31",
                  style: TextStyle(fontSize: 200,color: Color(0x10000000),fontWeight:FontWeight.w300))),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.exit_to_app),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonRow(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(24.0),
        child:Row(
          children: <Widget>[
            Expanded(
              child:MaterialButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color:Theme.of(context).accentColor)),
                child: Text("Tasks"),
                textColor: Colors.white,
                padding: EdgeInsets.all(14.0),
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              width: 32,
            )
            ,
            Expanded(
                child:MaterialButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color:Theme.of(context).accentColor )),
                  child: Text("Leaderboard"),
                  textColor: Theme.of(context).accentColor,
                  color: Colors.white ,
                  padding: EdgeInsets.all(14.0),
                )
            ),
          ],
        ));
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height:24),
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Text("Monday",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
          ),
        ),
        _buttonRow(context),
        Expanded(child:EventPage())

      ],
    );
  }
}