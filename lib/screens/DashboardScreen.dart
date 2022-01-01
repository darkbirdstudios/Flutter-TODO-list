import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_list_sqlit/screens/LoginScreen.dart';
import 'package:flutter_todo_list_sqlit/utils/database/sharedpreferencesHelper.dart';
import 'package:flutter_todo_list_sqlit/utils/database/sqliteHelper.dart';
import 'package:flutter_todo_list_sqlit/utils/model/TaskModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }


  Future<List> getTasks() async {
    List tasks = await DBProvider.dataBase.getTask();
    return tasks;
  }

  UpdatDialog(Task data) async {
    TextEditingController tasktextedit = TextEditingController(text: data.task);
    List<String> pp = ['Low', 'Modrate', 'High'];
    String? _selectedval = pp[data.priority];
    Dialog updateDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: tasktextedit,
                      decoration: const InputDecoration(
                        labelText: 'Task',
                      ),
                    ),
                  ),
                  Container(
                      child: DropdownButton(
                        hint: Text("Select priority"),
                        value: _selectedval,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedval = newValue.toString();
                          });
                        },
                        items: pp.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      )),
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                  Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Task addTask = Task(
                            id: data.id,
                            task: tasktextedit.text,
                            dateTime: data.dateTime,
                            priority: pp.indexOf(_selectedval!));
                        DBProvider.dataBase.updateTask(addTask);
                        Navigator.pop(context);
                      },
                      child: const Text("UPDATE TASK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          shape: const StadiumBorder()),
                    ),
                  )
                ],
              ),
            );
          }),
    );
    await showDialog(
        context: context, builder: (BuildContext context) => updateDialog);
    setState(() {});
  }

  AddDialog() async {
    TextEditingController tasktextedit = TextEditingController();
    List<String> pp = ['Low', 'Modrate', 'High'];
    String? _selectedval = 'Low';
    Dialog addDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: tasktextedit,
                      decoration: const InputDecoration(
                        labelText: 'Enter Task',
                      ),
                    ),
                  ),
                  Container(
                      child: DropdownButton(
                        hint: Text("Select priority"),
                        value: _selectedval,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedval = newValue.toString();
                          });
                        },
                        items: pp.map((location) {
                          return DropdownMenuItem(
                            child: Text(location),
                            value: location,
                          );
                        }).toList(),
                      )),
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                  Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        print(_selectedval);
                        if(tasktextedit.text.isNotEmpty && _selectedval != null){
                          Task addTask = Task(
                              task: tasktextedit.text,
                              dateTime: DateTime.now(),
                              priority: pp.indexOf(_selectedval!));
                          DBProvider.dataBase.addTask(addTask);
                          setState(() {});
                          Navigator.pop(context, true);
                        }else{
                          Fluttertoast.showToast(
                              msg: "Task Cannot be null",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }

                      },
                      child: const Text("ADD TASK"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          shape: const StadiumBorder()),
                    ),
                  )
                ],
              ),
            );
          }),
    );
    await showDialog(
        context: context, builder: (BuildContext context) => addDialog);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(opacity: 0.7,
              image: AssetImage("assets/dashboardimage.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("TODO LIST"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                onPressed: () {
                  sharedpreferencesHelper.prefs!.setBool("LoginStatus", false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: "Add Task",
            onPressed: () {
              AddDialog();
            },
          ),
          body: FutureBuilder(
            future: getTasks(),
            builder: (context, AsyncSnapshot taskData) {
              if (taskData.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (taskData.connectionState == ConnectionState.done) {
                if (taskData.data != null) {
                  var color;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: taskData.data.length,
                      itemBuilder: (context, index) {
                        int id = taskData.data[index]['id'];
                        String task = taskData.data[index]['task'].toString();


                        // DateTime.parse(taskData.data[index]['creationTime'])
                        //     .toString();
                        final DateFormat formatter = DateFormat('dd-MM-yyyy');
                        String formattedTime = DateFormat('kk:mm:a').format(
                            DateTime.parse(
                                taskData.data[index]['creationTime']));
                        String formattedDate = formatter.format(DateTime.parse(
                            taskData.data[index]['creationTime']));
                        String date = formattedDate + "  " + formattedTime;
                        int priority = taskData.data[index]['priority'];
                        if (priority == 0) {
                          color = Colors.blue;
                        } else if (priority == 1) {
                          color = Colors.green;
                        } else {
                          color = Colors.red;
                        }
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {
                              DBProvider.dataBase.deleteTask(id);
                              setState(() {});
                            }),
                            children: [
                              SlidableAction(
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                                onPressed: (BuildContext context) {
                                  DBProvider.dataBase.deleteTask(id);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                autoClose: true,
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                                onPressed: (BuildContext context) {
                                  UpdatDialog(Task(
                                      id: id,
                                      task: task,
                                      dateTime: DateTime.parse(
                                          taskData.data[index]['creationTime']),
                                      priority: priority));
                                },
                              ),
                            ],
                          ),
                          child: Container(
                            height: 80,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration:
                            BoxDecoration(color: Colors.black54,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      offset: const Offset(0, 9),
                                      blurRadius: 20,
                                      spreadRadius: 1)
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: color, width: 4)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(

                                      task,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20,),
                                    ),
                                    Text(
                                      date,
                                      style: const TextStyle(
                                          color: Colors.white60, fontSize: 13),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  height: 50,
                                  width: 7,
                                  color: color,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Start creating tasks",
                      style: TextStyle(fontSize: 22,color: Colors.white),
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
