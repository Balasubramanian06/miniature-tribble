import 'package:flutter/material.dart';


class LectureWidget extends StatefulWidget {

  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<LectureWidget> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(title:Text('Lectures')),
          body:LectureWidget(),
    );
  }
}