import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import './screens/attendence.dart';
import './screens/schedule.dart';
import './providers/students.dart';
import './screens/additional_learning.dart';
import './screens/assignments.dart';
import './screens/profile.dart';
import './providers/subject.dart';
import './screens/subjects_screen.dart';
import './screens/dashboard.dart';
import './screens/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Subjects(),
        ),
        ChangeNotifierProvider.value(
          value: Students(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        routes: {
          '/': (ctx) => Dashboard(),
          SubjectScreen.routeName: (ctx) => SubjectScreen(),
          Profile.routeName: (ctx) => Profile(),
          Assignments.routeName: (ctx) => Assignments(
                title: 'Assignments',
                platform: platform,
              ),
          AdditionalLearning.routeName: (ctx) => AdditionalLearning(),
          Attendences.routeName: (ctx) => Attendences(),
          Schedule.routeName: (ctx) => Schedule(),
          EditProfile.routeName: (ctx) => EditProfile(),
        },
      ),
    );
  }
}
