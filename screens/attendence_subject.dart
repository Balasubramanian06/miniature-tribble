import 'package:flutter/material.dart';

import '../providers/subject.dart';

class AttendenceSubject extends StatelessWidget {
  final String subId;
  AttendenceSubject({@required this.subId});
  Subject findById(String id) {
    List subjects = Subjects.subjects;
    return subjects.firstWhere((sub) => sub.subjectId == id);
  }

  @override
  Widget build(BuildContext context) {
    Subject subject = findById(subId);
    int present = subject.numberOfClassesAttended;
    int total = subject.numberOfClasses;
    // double attendence = present / total;
    return Column(
      children: <Widget>[
        Text(
          'Attendence ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text('Classes Attended'),
            subtitle: Text('present'),
            trailing: Text('$present'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text('Classes Conducted'),
            subtitle: Text('total classes'),
            trailing: Text('$total'),
          ),
        ),
      ],
    );
  }
}
