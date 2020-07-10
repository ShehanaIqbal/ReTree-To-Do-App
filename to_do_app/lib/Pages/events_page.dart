import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  final Map<String,dynamic> taskList;
  const EventPage({@required this.taskList});

  @override
  _EventPageState createState() => _EventPageState(this.taskList);
}

class Event {
  final String task;
  final String desc;
  final int status;
  final String url;

  const Event( this.task, this.desc, this.status,this.url);
}

class _EventPageState extends State<EventPage> {
  List<Event> _eventList=[
    new Event("Task 1","description 1",1,"https://flutter.dev/docs/cookbook/forms/validation"),
    new Event("Task 2","description 2",2,"https://flutter.dev/docs/cookbook/forms/validation"),
    new Event("Task 3","description 3",3,"https://flutter.dev/docs/cookbook/forms/validation"),
    new Event("Task 4","description 4",1,"https://flutter.dev/docs/cookbook/forms/validation"),
    new Event("Task 5","description 5",2,"https://flutter.dev/docs/cookbook/forms/validation"),
    new Event("Task 6","description 6",3,"https://flutter.dev/docs/cookbook/forms/validation"),
  ];
  final Map<String,dynamic> taskList;
  int status;
  Widget text;
  _EventPageState(this.taskList);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
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
  }

  Widget _displayContent(Event event) {
    final ValueNotifier<int> _counter = ValueNotifier<int>(event.status);
    status=event.status;
    text=_buildStatusButton(status);
    return Expanded(
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
                onPressed: (){
                      if (_counter.value==1){
                        _counter.value=2;
                        print("1 to 2");
                      }else if(_counter.value==2){
                        _counter.value=3;
                        print("2 to 3");
                      }else if(_counter.value==3){
                        _counter.value=1;
                        print("3 to 1");
                      }

                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ValueListenableBuilder(
                  builder: (BuildContext context, int value, Widget child) {
                    // This builder will only get called when the _counter
                    // is updated.
                    return _buildStatusButton(value);
                  },
                  valueListenable: _counter,
                  // The child parameter is most helpful if the child is
                  // expensive to build and does not depend on the value from
                  // the notifier.
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
      throw 'Could not launch $url';
    }
  }

  _changeStatus(){

  }

  Widget _buildStatusButton(int status){
    print(status);
    Widget text=Text("");
    if (status==1){
      text=Text("Pending",style: TextStyle(color: Colors.red));
    }else if (status==2){
      text=Text("On going",style: TextStyle(color: Colors.blue));
    }else{
      text=Text("Completed",style: TextStyle(color: Colors.green));
    }
    return (text);
  }


}