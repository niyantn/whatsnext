import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsnext/utilities/constants.dart';
import 'package:whatsnext/screens/tasks_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class DelTaskScreen extends StatefulWidget {
  @override
  _DelTaskScreenState createState() => _DelTaskScreenState();
}

class _DelTaskScreenState extends State<DelTaskScreen> {
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
  
  void _handleDelete(int taskid, String user, String pass) async{
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    
    final response = await http.delete(
      'https://whatsnext.page/api/tasks?task_id=$taskid',
      headers: {HttpHeaders.authorizationHeader: "Basic $encoded"},
    );
    if (response.statusCode == 204) {
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

  Widget _buildDescriptionTF(String description) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            description != null ? description : 'None',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerTF(List<dynamic> owners) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            'TODO',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }
  
  Widget _buildAssigneeTF(List<dynamic> assignees) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            'TODO',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }

  Widget _buildParentTF(int parentid) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            'TODO',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
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
              hintText: 'Enter the start date of the task',
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
              hintText: 'Enter the end date of the task',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSharedTF(List<dynamic> shared) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Shared',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            'TODO',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }
  Widget _buildStatusTF(String status) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            status != null ? status : 'None',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }
  Widget _buildPriorityTF(String priority) {
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
          //decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Text(
            priority != null ? priority : 'None',
            //controller: _descriptionController,
            //obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
            /*decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter the description of the task',
              hintStyle: kHintTextStyle,
            ),*/
          ),
        ),
      ],
    );
  }
  Widget _buildDeleteBtn(int taskid, String user, String pass) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _handleDelete(
          taskid,
          user,
          pass
          ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'DELETE',
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
    final ViewArguments args= ModalRoute.of(context).settings.arguments;
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
                        args.taskname,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildDescriptionTF(args.description),
                      SizedBox(height: 30.0),
                      _buildOwnerTF(args.owner),
                      SizedBox(height: 30.0),
                      _buildAssigneeTF(args.assignee),
                      SizedBox(height: 30.0),
                      _buildParentTF(args.parentid),
                      SizedBox(height: 30.0),
                      //_buildStartTF(),
                      //SizedBox(height: 30.0),
                      //_buildEndTF(),
                      //SizedBox(height: 30.0),
                      _buildSharedTF(args.shared),
                      SizedBox(height: 30.0),
                      _buildStatusTF(args.status),
                      SizedBox(height: 30.0),
                      _buildPriorityTF(args.priority),
                      SizedBox(height: 30.0),
                      _buildDeleteBtn(args.taskid, args.username, args.password),
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