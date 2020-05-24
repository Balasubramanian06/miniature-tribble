import 'package:flutter/material.dart';

import '../widgets/attendence_list.dart';
import '../widgets/this_period.dart';
import '../models/time_table.dart';
import '../providers/subject.dart';
import 'dart:async';

class Attendences extends StatefulWidget {
  static const routeName = '/attendences';
  @override
  State createState() => new _Attendences();
}

class _Attendences extends State<Attendences> {
  Timer _timer;
  DateTime _time;
  Subject _subject;

  Widget _buildProgressIndicator() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    _time = new DateTime.now();
    _subject = table[getMapNumber(_time)] ?? table[21];
    const duration = const Duration(seconds: 1);
    _timer = new Timer.periodic(duration, _updateTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    // print(new DateTime.now());
    // print(table[getMapNumber(_time)]);
    setState(() {
      _time = new DateTime.now();
      _subject = table[getMapNumber(_time)] ?? table[21];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Attendence and Schedule'),
      ),
      body: _subject.numberOfClasses == null
          ? _buildProgressIndicator()
          : new Center(
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: new ThisPeriod(_subject, _time),
                  ),
                  new Expanded(
                    flex: 8,
                    child: new AttendanceList(),
                  ),
                ],
              ),
            ),
    );
  }
}
