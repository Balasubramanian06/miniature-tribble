import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subject with ChangeNotifier {
  final String subjectId;
  final String subTitle;
  final String facultyName;
  SharedPreferences _prefs;

  int _numberOfClasses;
  int _numberOfClassesAttended;

  int get numberOfClassesAttended => _numberOfClassesAttended;
  int get numberOfClasses => _numberOfClasses;
  _setSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('${subjectId}_noc', _numberOfClasses);
    _prefs.setInt('${subjectId}_noca', _numberOfClassesAttended);
  }

  _getSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    _numberOfClasses = _prefs.getInt('${subjectId}_noc') ?? 0;
    _numberOfClassesAttended = _prefs.getInt('${subjectId}_noca') ?? 0;
  }

  Subject(
    this.subjectId,
    this.subTitle,
    this.facultyName,
  ) {
    _getSavedData();
  }
  void registerPresent() {
    _numberOfClasses++;
    _numberOfClassesAttended++;
    _setSavedData();
  }

  void registerAbsent() {
    _numberOfClasses++;
    _setSavedData();
  }
}

class Subjects with ChangeNotifier {
  static Subject tVLSI = new Subject(
    'Mat1001',
    'Maths',
    'Mathfac',
  );
  static Subject tDSP = new Subject(
    'Sci1001',
    'Science',
    'Sciencefac',
  );
  static Subject tOptical = new Subject(
    'Soc1001',
    'Social',
    'Socialfac',
  );
  static Subject tNetworking = new Subject(
    'Comp1001',
    'Computer',
    'Computerfac',
  );
  static Subject tOOP = new Subject(
    'Eng1001',
    'English',
    'Englishfac',
  );
  static Subject tPOM = new Subject(
    'Tam1001',
    'Tamil',
    'Tamilfac',
  );
  static Subject tPD = new Subject(
    'Per1001',
    'Personality Development',
    'Oslafac',
  );
  static Subject free = new Subject(
    'CSEN3204',
    'No classes right now',
    'KD',
  );

  static List<Subject> subjects = <Subject>[
    tVLSI,
    tDSP,
    tOptical,
    tNetworking,
    tOOP,
    tPOM,
    tPD,
  ];
  List<Subject> get items {
    return [...subjects];
  }
   
}
