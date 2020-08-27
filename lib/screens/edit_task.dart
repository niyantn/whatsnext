import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsnext/utilities/constants.dart';
import 'package:whatsnext/screens/tasks_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class EditTaskScreen extends StatefulWidget {
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _tasknameController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _ownerController = new TextEditingController();
  final TextEditingController _assigneeController = new TextEditingController();
  final TextEditingController _parentController = new TextEditingController();
  final TextEditingController _startController = new TextEditingController();
  final TextEditingController _endController = new TextEditingController();
  final TextEditingController _sharedController = new TextEditingController();
  final TextEditingController _statusController = new TextEditingController();
  final TextEditingController _priorityController = new TextEditingController();
  
  void _handlePut(int taskid,
                  String user,
                  String pass,
                  String taskname, 
                  String description,
                  String parent,
                  String start,
                  String end,
                  String status,
                  String priority) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    var response;
    if (status == '' && priority == ''){
      response = await http.put(
        'https://whatsnext.page/api/tasks?task_id=$taskid&taskname=$taskname&description=$description&parent=$parent&start=$start&end=$end',
        headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
      );
    }
    else{
      response = await http.put(
        'https://whatsnext.page/api/tasks?task_id=$taskid&taskname=$taskname&description=$description&parent=$parent&start=$start&end=$end&status=$status&priority=$priority',
        headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
      );
    }
    if (response.statusCode == 200) {
      _tasknameController.clear();
      _descriptionController.clear();
      _ownerController.clear();
      _assigneeController.clear();
      _parentController.clear();
      _startController.clear();
      _endController.clear();
      _sharedController.clear();
      _statusController.clear();
      _priorityController.clear();
      Navigator.of(context).pop();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _addOwner(int taskid, String user, String pass, String owner) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=add&task_id=$taskid&owner=$owner',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _ownerController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _remOwner(int taskid, String user, String pass, String owner) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=remove&task_id=$taskid&owner=$owner',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _ownerController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _addAssignee(int taskid, String user, String pass, String assignee) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=add&task_id=$taskid&assignee=$assignee',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _assigneeController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _remAssignee(int taskid, String user, String pass, String assignee) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=remove&task_id=$taskid&assignee=$assignee',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _assigneeController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _addShared(int taskid, String user, String pass, String shared) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=add&task_id=$taskid&shared_with=$shared',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _sharedController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  void _remShared(int taskid, String user, String pass, String shared) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final response = await http.patch(
      'https://whatsnext.page/api/tasks?action=remove&task_id=$taskid&shared_with=$shared',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
      _sharedController.clear();
    }
    else{
      throw Exception(response.body);
    }
  }
  Widget _buildTasknameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Taskname',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _tasknameController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              hintText: 'Enter the new name of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Description',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new description of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerTF(int taskid, String user, String pass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Owner',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _ownerController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () => _addOwner(taskid, user, pass, _ownerController.text)
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white),
                    onPressed: () => _remOwner(taskid, user, pass, _ownerController.text)
                  ),
                ],
              ),
              hintText: 'Add/remove a task owner',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAssigneeTF(int taskid, String user, String pass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Assignee',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _assigneeController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () => _addAssignee(taskid, user, pass, _assigneeController.text)
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white),
                    onPressed: () => _remAssignee(taskid, user, pass, _assigneeController.text)
                  ),
                ],
              ),
              hintText: 'Add/remove a task assignee',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParentTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Parent',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _parentController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new parent task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Start Date',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _startController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new start date of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildEndTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'End Date',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _endController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new end date of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSharedTF(int taskid, String user, String pass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Shared User',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _sharedController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                mainAxisSize: MainAxisSize.min, // added line
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () => _addShared(taskid, user, pass, _sharedController.text)
                  ),
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white),
                    onPressed: () => _remShared(taskid, user, pass, _sharedController.text)
                  ),
                ],
              ),
              hintText: 'Add/remove a shared user of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildStatusTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Status',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _statusController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new status of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPriorityTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Priority',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _priorityController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the new priority of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildUpdateBtn(int taskid, String user, String pass) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _handlePut(
          taskid,
          user,
          pass,
          _tasknameController.text,
          _descriptionController.text,
          _parentController.text,
          _startController.text,
          _endController.text,
          _statusController.text,
          _priorityController.text,
          ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'UPDATE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final EditArguments args= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          //onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  //physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 80.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Edit Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildTasknameTF(),
                      SizedBox(height: 30.0),
                      _buildDescriptionTF(),
                      SizedBox(height: 30.0),
                      _buildOwnerTF(args.taskid, args.username, args.password),
                      SizedBox(height: 30.0),
                      _buildAssigneeTF(args.taskid, args.username, args.password),
                      SizedBox(height: 30.0),
                      _buildParentTF(),
                      SizedBox(height: 30.0),
                      //_buildStartTF(),
                      //SizedBox(height: 30.0),
                      //_buildEndTF(),
                      //SizedBox(height: 30.0),
                      _buildSharedTF(args.taskid, args.username, args.password),
                      SizedBox(height: 30.0),
                      _buildStatusTF(),
                      SizedBox(height: 30.0),
                      _buildPriorityTF(),
                      SizedBox(height: 30.0),
                      _buildUpdateBtn(args.taskid, args.username, args.password),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}