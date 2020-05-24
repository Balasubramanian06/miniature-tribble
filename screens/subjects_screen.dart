import 'package:flutter/material.dart';




import 'attendence_subject.dart';
import 'drawer.dart';
import 'notes.dart';
import '../widgets/lecture_widget.dart';
import '../widgets/quiz_widget.dart';
import '../providers/subject.dart';



class SubjectScreen extends StatefulWidget {
  static const routeName = '/subject-screen';

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  int _selectedIndex =0;
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Subject findById(String id){
    List subjects =Subjects.subjects;
    return subjects.firstWhere((sub) => sub.subjectId== id);
  }
  @override
  Widget build(BuildContext context) {
  final String subId = ModalRoute.of(context).settings.arguments;
   Subject subject = findById(subId);
    final List<Widget> _widgetOptions =<Widget>[
    Notes(),
    QuizWidget(subId: subId,),
    LectureWidget(),
    //ScheduleSubject(),
    AttendenceSubject(subId: subId,),
  ];
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(subject.subTitle),
        ),
        drawer: AppDrawer(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.lightBlue,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              title: Text('Notes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              title: Text('quiz'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.personal_video),
              title: Text('Classes'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Attendence'),
            ),
          ],
        ),
      ),
    );
  }
}
