import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/subject.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizWidget extends StatefulWidget {
  final String subId;
  QuizWidget({@required this.subId});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  var _expanded = false;
  Subject findById(String id) {
    List subjects = Subjects.subjects;
    return subjects.firstWhere((sub) => sub.subjectId == id);
  }

  _launchURL() async {
    const url = "https://google.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Subject subject = findById(widget.subId);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(200, 350) : 134,
      child: Column(
        children: <Widget>[
          Text(
            'Quiz',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(' ${subject.subTitle} Quiz'),
                    trailing: IconButton(
                      icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(
                          () {
                            _expanded = !_expanded;
                          },
                        );
                      },
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _expanded ? min(60, 200) : 0,
                  alignment: Alignment.topLeft,
                  child: FlatButton(
                    onPressed: _launchURL,
                    child: Text('click to start quiz'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
