import 'package:flutter/material.dart';
import 'package:whatsnext/utilities/styles.dart';
import 'package:whatsnext/screens/nav_drawer.dart';
import 'package:whatsnext/screens/tasks_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class SharedTaskScreen extends StatefulWidget {
  @override
  _SharedTaskScreenState createState() => _SharedTaskScreenState();
}
class _SharedTaskScreenState extends State<SharedTaskScreen> {
  Future<TaskList> usertasks; 

  Future<TaskList> getTasks(user, pass) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.get(
      'https://whatsnext.page/api/tasks?shared_with=$user',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty){
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
        title: Text('Shared With You'),
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