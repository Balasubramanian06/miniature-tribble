import 'package:flutter/material.dart';
import 'package:tryout/screens/assignments.dart';
import 'package:tryout/screens/attendence.dart';

import './profile.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Leanings fun..'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Attendence ,Schedule'),
            onTap: () {
              Navigator.of(context).pushNamed(Attendences.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Assignments'),
            onTap: () {
              Navigator.of(context).pushNamed(Assignments.routeName);
            },
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.book),
          //   title: Text('Additional Learning'),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(AdditionalLearning.routeName);

          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.schedule),
          //   title: Text('Schedule'),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(Schedule.routeName);
          //   },
          // ),
          Divider(),
           ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(Profile.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
