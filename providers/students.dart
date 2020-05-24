import 'package:flutter/foundation.dart';

class Student with ChangeNotifier {
  String id;
  String name;
  double attendence;
  final String imageUrl;
  String mobileNumber;
  String parentName;
  String emailId;

  Student({
    @required this.id,
    this.attendence,
    @required this.name,
    this.imageUrl,
    @required this.mobileNumber,
    @required this.parentName,
    @required this.emailId,
  });
}

class Students with ChangeNotifier {
  List<Student> _items = [
    Student(
        id: '120',
        name: 'Student',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTEE4wMI4iq3faNnWfb-mnj2LvfiwRxb1ai3GBUr2ggSgTsl9Ut&usqp=CAU',
        mobileNumber: '63832246233',
        parentName: 'parent',
        emailId: 'baaabois@gmail.com'),
  ];
  List<Student> get items {
    return [..._items];
  }

  Future<void> updateProfile(String id, Student student) async {
    for (int i = 0; i < _items.length; i++)
      if (_items[i].id == id) {
        _items[i].name = student.name;
        _items[i].parentName = student.parentName;
        _items[i].mobileNumber = student.mobileNumber;
        _items[i].emailId = student.emailId;
      }
      notifyListeners();
  }
}
