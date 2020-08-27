import 'package:flutter/material.dart';
import 'package:whatsnext/screens/tasks_screen.dart';

class NavDrawer extends StatelessWidget {
  final String username;
  final String password;

  NavDrawer({Key key, @required this.username, @required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'WhatsNext',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Create New Task'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushNamed(
                context, 
                '/create', 
                arguments: ScreenArguments(this.username, this.password),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Owned Tasks'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushNamed(
                context, 
                '/tasks', 
                arguments: ScreenArguments(this.username, this.password),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.supervisor_account),
            title: Text('Assigned Tasks'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushNamed(
                context, 
                '/asstasks', 
                arguments: ScreenArguments(this.username, this.password),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Shared Tasks'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.pushNamed(
                context, 
                '/sharedtasks', 
                arguments: ScreenArguments(this.username, this.password),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop(),
              Navigator.pushNamed(
                context, 
                '/',
              )},
          ),
        ],
      ),
    );
  }
}