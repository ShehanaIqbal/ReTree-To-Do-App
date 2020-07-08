import 'package:flutter/material.dart';
import 'Pages/tasks_page.dart';
import 'Pages/events_page.dart';
import 'Pages/main_content.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          _login(context),
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
