import 'dart:async';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LinearProgressIndicatorAppState();
  }
}

class _LinearProgressIndicatorAppState extends State<ProgressBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
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
                          center: Text("Loading..."),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}