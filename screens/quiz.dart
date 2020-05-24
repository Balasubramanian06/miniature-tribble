
import 'package:flutter/material.dart';
import '../providers/subject.dart';
import'../widgets/quiz_widget.dart';
class Quizes extends StatelessWidget {
  static const routeName='quiz';
  final String subId;
  Quizes({@required this.subId});


   Subject findById(String id) {
    List subjects = Subjects.subjects;
    return subjects.firstWhere((sub) => sub.subjectId == id);
  }
  @override
  Widget build(BuildContext context) {
    Subject subject = findById(subId);
    return Scaffold(
          appBar: AppBar(title: Text('${subject.subTitle} Quiz'),),
          body:QuizWidget(subId:subId),
    );
  }
}
