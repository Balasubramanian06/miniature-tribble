import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryout/screens/profile.dart';

import '../providers/subject.dart';
import '../widgets/dashboad_item.dart';
import './drawer.dart';
import './subjects_screen.dart';

enum options{
  Profile,
}

class Dashboard extends StatefulWidget {
  static const routeName = '/Dash_board';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final subject = Provider.of<Subjects>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(' Subjects'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Profile'), value: options.Profile),
            ],
            onSelected: (options value) {
              if(value == options.Profile){
                Navigator.of(context).pushNamed(Profile.routeName);
              }

            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    SubjectScreen.routeName,
                    arguments: subject.items[i].subjectId,
                  ),
                  child: DashBoardItem(
                    id: subject.items[i].subjectId,
                    title: subject.items[i].subTitle,
                    facultyName: subject.items[i].facultyName,
                  ),
                );
              },
              itemCount: subject.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
