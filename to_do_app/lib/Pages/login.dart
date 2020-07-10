import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mobile;
  String password;
  bool _isUploading=false;
  String url;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  String getMobile(){
    setMobile();
    return mobile;
  }

  String getPassword(){
    setPassword();
    return password;
  }

  void setMobile(){
    this.mobile=usernameController.text.toString();
  }

  void setPassword(){
    this.password=passwordController.text.toString();
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
    });
  }

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
    return Form(
      key: _formKey,
      child: Column(
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
              child:TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
                controller: usernameController,
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
            child:TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              controller: passwordController,
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
              if (_formKey.currentState.validate()) {
                _uploadCredentials();
              }

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

  String getURL() {
    String url = 'http://192.168.8.108:3000/user/' +
        getMobile() + '/' +
        getPassword();
    return url;
  }

  void navigateToTasks() {
    Navigator.of(context).pushReplacementNamed('/tasks');
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
        final Map<String, dynamic> prediction = json.decode(response.body);
//        _resetState();
        print(prediction);
        Toast.show("Login successful!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        navigateToTasks();
        return prediction;
      } else {
        print(response.toString());
        Toast.show("Login failed! Please retry.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print ("null");
        Alert(
          style: AlertStyle(backgroundColor:Colors.white.withOpacity(0.75) ),
          context: context,
//          type: AlertType.warning,
          title: "Error",
          desc: "Failed to login",
          buttons: [
            DialogButton(
              color: Colors.green.withOpacity(0.75),
              child: Text(
                "Retry",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        return null;
      }
    } catch (e) {
      Toast.show("Login failed! Please retry.", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print (e);
      return null;
    }
  }



}
