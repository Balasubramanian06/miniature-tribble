import 'package:flutter/material.dart';
import '../providers/subject.dart';
import 'attendence_item.dart';

class AttendanceList extends StatelessWidget{
  List<Widget> counterList(){
    final  List<Widget> counterList = <Widget>[];
    for(Subject subject in Subjects.subjects){
      counterList.add(new AttendanceItem(subject));
    }
    return counterList;
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new ListView(
        children: counterList(),
      ),
    );
  }
}