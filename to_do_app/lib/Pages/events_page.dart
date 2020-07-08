import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String task;
  final String desc;
  final bool isFinish;

  const Event( this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
  new Event("Meeting 1 to be held","Refer the link",true),
  new Event("Meeting 2 to be held","Description 1",true),
  new Event("Meeting 3 to be held","Description 2",true),
  new Event("Meeting 4 to be held","Description 3",false),
  new Event("Meeting 5 to be held","Description 4",false),
  new Event("Meeting 6 to be held","Description 5",false)
];

class _EventPageState extends State<EventPage> {
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
                onTap: _launchURL,
                child: Text('Open link',style: TextStyle(color: Theme.of(context).accentColor),),
              ),
            ],

             ),
              Spacer(),
              Align(
                alignment: Alignment.topRight,
              child:Padding(
                padding: EdgeInsets.only(right: 12.0),
                  child:MaterialButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color:Colors.white)),
                child: Text("Pending"),
                textColor: Theme.of(context).accentColor,
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

  Widget _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}