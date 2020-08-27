import 'package:flutter/material.dart';
import 'package:whatsnext/utilities/styles.dart';
import 'package:whatsnext/screens/nav_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}
class _TaskScreenState extends State<TaskScreen> {
  Future<TaskList> usertasks; 
  final fbm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
  }

  Future<TaskList> getTasks(user, pass) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.get(
      'https://whatsnext.page/api/tasks?owner=$user',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 200) {
      if (response.body.contains("task_id")){
        return TaskList.fromJson(json.decode(response.body));
      }
      else {
        return null;
      }
    } else {
      throw Exception('Failed to load post');
    }
  }
/*
  @override
  void initState() {
    
    super.initState();
    
  }
*/
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    usertasks = getTasks(args.username, args.password);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tasks'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )
          ),
        ],
      ),
      drawer: NavDrawer(username: args.username, password: args.password),
      body: Center(
        child: FutureBuilder<TaskList>(
          future: usertasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Task> tasks = snapshot.data.tasks;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index){
                  var task = tasks[index];
                  return ListTile(
                    //contentPadding: EdgeInsets.all(10.0),
                    title: Text(task.taskname, style: Styles.textDefault),
                    trailing: IconButton(
                      icon: Icon(Icons.unfold_more),
                      onPressed: ()=>{
                        Navigator.pushNamed(
                          context, 
                          '/edit', 
                          arguments: EditArguments(task.taskid, args.username, args.password),
                        )
                      }
                    ),
                    onTap: () => {
                      Navigator.pushNamed(
                          context, 
                          '/delete', 
                          arguments: ViewArguments(task.taskid, 
                                                  task.taskname, 
                                                  task.description,
                                                  task.owner,
                                                  task.assignee,
                                                  task.parentid,
                                                  task.start,
                                                  task.end,
                                                  task.shared,
                                                  task.status,
                                                  task.priority,
                                                  args.username, args.password),
                      )
                    }
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String username;
  final String password;

  ScreenArguments(this.username, this.password);
}
class EditArguments{
  final int taskid;
  final String username;
  final String password;

  EditArguments(this.taskid, this.username, this.password);
}
class ViewArguments{
  final int taskid;
  final String taskname;
  final String description;
  final List<String> owner;
  final List<String> assignee;
  final int parentid;
  final String start;
  final String end;
  final List<String> shared;
  final String status;
  final String priority;
  final String username;
  final String password;

  ViewArguments(this.taskid, this.taskname, this.description, this.owner, this.assignee, this.parentid, this.start, this.end, this.shared, this.status, this.priority, this.username, this.password);
}
class Task {
  final int taskid;
  final String taskname;
  final String description;
  final List<String> owner;
  final List<String> assignee;
  final int parentid;
  final String start;
  final String end;
  final List<String> shared;
  final String status;
  final String priority;
  Task({this.taskid, 
            this.taskname, 
            this.description, 
            this.owner, 
            this.assignee, 
            this.parentid, 
            this.start, 
            this.end,
            this.shared, 
            this.status, 
            this.priority});
  factory Task.fromJson(Map<String, dynamic> task){
    List<String> owners = new List<String>();
    if (task['owner'] != null){
      owners = task['owner'].cast<String>();
    }
    List<String> assignees = new List<String>();
    if (task['assignee'] != null){
      assignees = task['assignee'].cast<String>();
    }
    List<String> sharedusers = new List<String>();
    if (task['shared'] != null){
      sharedusers = task['shared'].cast<String>();
    }
    return Task(
      taskid: task['task_id'],
      taskname: task['taskname'], 
      description: task['description'], 
      owner: owners, 
      assignee: assignees, 
      parentid: task['parent'], 
      start: task['start'], 
      end: task['end'], 
      shared: sharedusers, 
      status: task['status'], 
      priority: task['priority']
    );
  }
}

class TaskList {
    final List<Task> tasks;
    TaskList({
      this.tasks,
    });

    factory TaskList.fromJson(List<dynamic> parsedJson) {

    List<Task> tasks = new List<Task>();
    tasks = parsedJson.map((i)=>Task.fromJson(i)).toList();

    return new TaskList(
      tasks: tasks
    );
  }
}