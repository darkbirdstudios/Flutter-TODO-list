class Task{
  int? id;
  final String task;
  DateTime? dateTime;
  final int priority;


  Task({this.id,required this.task,this.dateTime,required this.priority});

  Map<String,dynamic> toMap(){
    return ({
      'id':id,
      'task':task,
      'CreationTime':dateTime.toString(),
      'priority':priority
    });
  }
}