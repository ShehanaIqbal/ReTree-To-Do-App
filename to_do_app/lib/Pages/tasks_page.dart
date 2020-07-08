import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget{
  _TaskPageState createState() => _TaskPageState();
}

class Task{
  final String task;
  final bool isFinish;
  const Task(this.task,this.isFinish);
}

final List<Task> _taskList=[
  new Task("Task Completed", true),
  new Task("Task Completed", true),
  new Task("Task Completed", true),
  new Task("Task Completed", true),
  new Task("Task Incomplete", false),
  new Task("Task Incomplete", false),
];

class _TaskPageState extends State<TaskPage>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: _taskList.length,
        itemBuilder: (context,index){
          return _taskList[index].isFinish?_taskComplete(_taskList[index].task):_taskIncomplete(_taskList[index].task);
        }
    );
  }

  Widget _taskIncomplete(String task){
    return Padding(padding: EdgeInsets.all(8.0),
      child:Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_unchecked,
            color: Theme.of(context).accentColor,
            size: 20,
          ),
          SizedBox(width: 4.0),
          Text(task)
        ],
      ),
    );
  }

  Widget _taskComplete(String task) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child:Padding(padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.radio_button_checked,
              color: Theme
                  .of(context)
                  .accentColor,
              size: 20,
            ),
            SizedBox(width: 4.0),
            Text(task)
          ],
        ),
      ),
    );
  }
}