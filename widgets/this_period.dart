import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/subject.dart';
import 'colors.dart';

class ThisPeriod extends StatelessWidget {
  final Subject _subject;
  final DateTime _time;
  final DateFormat _formatter = DateFormat.jm();
  final NumberFormat _percentFormatter = NumberFormat.percentPattern();

  ThisPeriod(this._subject, this._time);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 65.0,
        color: bigCardBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _subject.subTitle,
              style: TextStyle(color: bigCardSmallText, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Subjects',
                  style: TextStyle(color: bigCardSmallText, fontSize: 20.0),
                ),
                SizedBox(width: 40,),
                Text(
                  _percentFormatter.format((_subject.numberOfClassesAttended /
                      _subject.numberOfClasses)),
                  style: TextStyle(color: bigCardSmallText, fontSize: 20.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
