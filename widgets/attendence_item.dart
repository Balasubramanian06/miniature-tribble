import 'package:flutter/material.dart';

import '../providers/subject.dart';
import 'colors.dart';

class AttendanceItem extends StatefulWidget {
  final Subject subject;
  AttendanceItem(this.subject);
  @override
  State createState() => _AttendanceItem(subject);
}

class _AttendanceItem extends State<AttendanceItem> {
  Subject subject;
  _AttendanceItem(this.subject);

  void registerPresent() {
    setState(() => subject.registerPresent());
  }

  void registerAbsent() {
    setState(() => subject.registerAbsent());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        height: 90.0,
        color: smallCardBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    subject.subTitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: smallCardSmallText,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  Text(subject.subjectId,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: smallCardBigText,
                          fontSize: 16.0)),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: absentButtonColor,
                ),
                child: MaterialButton(
                  onPressed: () {
                    registerAbsent();
                  },
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: presentButtonColor,
                ),
                child: MaterialButton(
                  onPressed: () {
                    registerPresent();
                  },
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${subject.numberOfClassesAttended}/${subject.numberOfClasses}',
                      style:
                          TextStyle(color: smallCardSmallText, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
