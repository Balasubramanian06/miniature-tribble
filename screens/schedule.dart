import 'package:flutter/material.dart';
import 'package:tryout/providers/subject.dart';

import '../models/time_table.dart';

class Schedule extends StatefulWidget {
  static const routeName = '/Schedule';

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    Map<int, Subject> schedule =items;

    return Scaffold(
        appBar: AppBar(
          title: Text('Schedule'),
        ),
        body: Center(
          child: Text(schedule.values.toList()[1].subTitle)
        ),);
  }
}
