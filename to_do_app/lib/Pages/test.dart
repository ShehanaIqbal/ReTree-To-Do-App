import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todoapp/Pages/progressBar.dart';
import 'Event.dart';
import 'events_page.dart';

class Events extends StatelessWidget {
  final Future<List<Event>> events;
  Events({Key key, this.events}) : super(key: key);
  // final items = Product.getProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Center(
          child: FutureBuilder<List<Event>>(
            future: events, builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? EventPage(taskList: snapshot.data):

            // return the ListView widget :
            ProgressBar();
          },
          ),
        )
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.item}) : super(key: key);
  final Event item;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2), height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.task, style:TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.desc),
                            Text("Price: " + this.item.url.toString()),
                          ],
                        )
                    )
                )
              ]
          ),
        )
    );
  }
}

