import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/Pages/progressBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import './Event.dart';
class EventPage extends StatefulWidget {
  final List<Event> taskList;
  const EventPage({@required this.taskList});

  @override
  _EventPageState createState() => _EventPageState(this.taskList);
}

class _EventPageState extends State<EventPage> {
  final List<dynamic> _eventList;
  Widget text;
  bool _updating=false;
  _EventPageState(this._eventList);

  Future _onUpdate() async {
    setState(() {
      _updating = true;
    });
    print("onupdate");
    print (_updating);
  }

  Future _updated() async{
    await Future.delayed(Duration(seconds: 2));
    setState((){
      _updating = false;
    });
    print("updated");
    print (_updating);
    navigateToTasks();
  }

  @override
  Widget build(BuildContext context) {
    var list= ListView.builder(
      itemCount: _eventList.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Row(
            children: <Widget>[
              _displayContent(_eventList[index])
            ],
          ),
        );
      },
    );
    var loading=Center(
      child: new SizedBox(
        height: 120.0,
        width: 120.0,
        child: LiquidCircularProgressIndicator(
          value: 0.40, // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(Colors.green), // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.lightGreen,
          borderWidth: 1.0,
          direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          center: Text("Updating..."),
        ),
      ),
    );
    if (_updating){
      return loading;
    }else{
      return list;
    }
  }

  Widget _displayContent(Event event) {
    final ValueNotifier<int> _counter = ValueNotifier<int>(event.status);
    int status=event.status;
    text=_buildStatusButton(status);
    var content= Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Row(
            children:<Widget>[
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.task,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: 12,
              ),
              Text(event.desc),
              SizedBox(height: 12.0,),
              InkWell(
                onTap: (){
                  _launchInBrowser(event.url);
                },
                child: Text('Open link',style: TextStyle(color: Colors.black45),),
              ),
            ],

             ),
              Spacer(),
              Align(
                alignment: Alignment.topRight,
              child:Padding(
                padding: EdgeInsets.only(right: 12.0),
                  child:MaterialButton(
                    minWidth: 120.0,
                onPressed: () async {
                  bool updated=await getId(_counter.value, event.taskId);
                  if (updated==true){
                    if (_counter.value == 1) {
                      _counter.value = 2;
                      print("1 then 2");
                    } else if (_counter.value == 2) {
                      _counter.value = 3;
                      print("2 then 3");
                    } else if (_counter.value == 3) {
                      _counter.value = 1;
                      print("3 then 1");
                    }
                  }
                  print("hiii");
                  print(_counter.value);
                  setState(() {
                    text=_buildStatusButton(_counter.value);
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ValueListenableBuilder(
                  builder: (BuildContext context, int value, Widget child) {
                    return _buildStatusButton(value);
                  },
                  valueListenable: _counter,
                ),
                textColor: Colors.green,
                padding: EdgeInsets.all(14.0),
                color: Colors.white,
                  ),
              ),
              )
          ]
          ),
        ),
      ),
    );
    var loading=Center(
      child: new SizedBox(
        height: 120.0,
        width: 120.0,
        child: LiquidCircularProgressIndicator(
          value: 0.40, // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(Colors.green), // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.lightGreen,
          borderWidth: 2.0,
          direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          center: Text("Loading..."),
        ),
      ),
    );

      return content;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
//      int id= await getId();
//      print(id);
      throw 'Could not launch $url';
    }
  }

  Future<bool> getId(int status,int taskId) async {
//    print("getid");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId');
//    print(userId);
    await _onUpdate();
    try {
      status=await changeStatus(status);
      final response = await http.get(getURL(userId,taskId,status));
      if (response.statusCode == 200) {
        print("200");
        final Map<String, dynamic> resp = json.decode(response.body);
        print(resp);
        await _updated();
        return true;
      } else {
        print ("response");
        print(response.toString());
        _updated();
        Alert(
          style: AlertStyle(backgroundColor:Colors.white.withOpacity(0.75) ,isCloseButton: false,
            isOverlayTapDismiss: false,titleStyle: TextStyle(
              fontSize: 17.0,fontWeight: FontWeight.w600,
            ),descStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.black45),),
          context: context,
          title: "Error",
          desc: "Failed to update the activity status",
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
        return false;
      }
    } catch (e) {
      print (e);
      await _updated();
      Alert(
        style: AlertStyle(backgroundColor:Colors.white.withOpacity(0.75) ,isCloseButton: false,
          isOverlayTapDismiss: false,titleStyle: TextStyle(
            fontSize: 17.0,fontWeight: FontWeight.w600,
          ),descStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.black45),),
        context: context,
        title: "Error",
        desc: "Network Failure",
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
      return false;
    }
  }

  Widget _buildStatusButton(int status) {
    Widget text=Text("");
    if (status==1){
      text=Text("Pending",style: TextStyle(color: Colors.red));
    }else if (status==2){
      text=Text("On Going",style: TextStyle(color: Colors.blue));
    }else{
      text=Text("Completed",style: TextStyle(color: Colors.green));
    }
    return (text);
  }

  String getURL(int userId,int taskId,int status) {
    String url = 'http://192.168.8.108:3000/updatestatus/'+userId.toString()+'/'+taskId.toString()+'/'+status.toString();
    return url;
  }

  Future<int> changeStatus(int status) async{
    if (status == 1) {
      status = 2;
      print("1 to 2");
    } else if (status == 2) {
      status = 3;
      print("2 to 3");
    } else if (status == 3) {
      status = 1;
      print("3 to 1");
    }
    return status;
  }

  void navigateToTasks() {
    Navigator.of(context).pushReplacementNamed('/tasks');
  }

}