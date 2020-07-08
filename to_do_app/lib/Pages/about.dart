import 'package:flutter/material.dart';
import './tasks_page.dart';
import './events_page.dart';
import './main_content_tasks.dart';

class AboutPage extends StatefulWidget {

  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _mainContent(context),
          Container(height: 35,
              color: Theme.of(context).accentColor),
          _login(context),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.0,right: 24.0),
    child:FloatingActionButton(
        onPressed: (){

        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_back),
      )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height:24),
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Text("About Us",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)
          ),
        ),
      ],
    );
  }

  _login(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(12.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child:Text("About us")
          )
        ],

      ),
    );
  }
}