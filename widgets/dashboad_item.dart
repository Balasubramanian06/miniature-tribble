import 'package:flutter/material.dart';
// import 'package:tryout/screens/lectures.dart';
// import 'package:tryout/screens/quiz.dart';
// import 'package:tryout/screens/subjects_screen.dart';

// enum options{
//   Subject,
//   Quiz,
//   Lecture,
// }
class DashBoardItem extends StatelessWidget {
  final String id;
  final String title;
  final String facultyName;

  DashBoardItem(
      {@required this.id, @required this.title, @required this.facultyName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${title[0]}'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('name $facultyName'),
          //   trailing:  PopupMenuButton(
          //   icon: Icon(Icons.more_vert),
          //   itemBuilder: (_) => [
          //     PopupMenuItem(child: Text('Subject'), value: options.Subject),
          //     PopupMenuItem(child: Text('Lecture'), value: options.Lecture),
          //     PopupMenuItem(child: Text('Quiz'), value: options.Quiz),

          //   ],
          //   onSelected: (options value) {
          //     if(value == options.Subject){
          //       Navigator.of(context).pushNamed(SubjectScreen.routeName);
          //     }
          //     else if(value == options.Subject){
          //       Navigator.of(context).pushNamed(Quizes.routeName);
          //     }else if(value == options.Subject){
          //       Navigator.of(context).pushNamed(Lecture.routeName);
          //     }
          //   }
          // )
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
