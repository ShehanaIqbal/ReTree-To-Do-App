class Event {
  final int taskId;
  final String task;
  final String desc;
  final String score;
  final String url;
  final int status;
  const Event( this.taskId,this.task, this.desc, this.score,this.url,this.status);
  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
      int.parse(json['Id'].toString()),
      json['title'].toString(),
      json['desc'].toString(),
      json['score'].toString(),
      json['link'].toString(),
      int.parse(json['status'].toString()),
    );
  }
}