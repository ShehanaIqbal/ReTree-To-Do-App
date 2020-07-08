import 'package:flutter/material.dart';
import './tasks_page.dart';
import './events_page.dart';
import './main_content_tasks.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height:24),

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
          Padding(
              padding: EdgeInsets.all(24.0),
              child:Text("LOGIN",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor
                ),)
          ),
          Padding(
              padding: EdgeInsets.all(24.0),
              child:TextField(
                obscureText: false,
                cursorColor: Theme.of(context).accentColor,
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Username",
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
              )
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child:TextField(
              obscureText: true,
              cursorColor: Theme.of(context).accentColor,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Password",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
            ),
          ),
          MaterialButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainContent()),
              );
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color:Theme.of(context).accentColor )),
            child: Text("Login"),
            textColor: Theme.of(context).accentColor,
            color: Colors.white ,
            padding: EdgeInsets.all(14.0),

          ),
        ],

      ),
    );
  }
}
