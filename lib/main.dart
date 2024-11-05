import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_work/db_study_work/db_study_work.dart';
import 'package:study_work/target/target_names.dart';
import 'package:study_work/target/target_pages.dart';

Color primaryColor = const Color(0xff1f90e3);
Color bgColor = const Color(0xfff7f7f7);

List<String> taskTypes = ['Work','Study'];
List<String> taskFinishTitles = ['Not done ','Completed'];

List<Color> taskColors = [
  Colors.deepPurple,
  primaryColor,
  Colors.green,
  const Color(0xfffdb211),
  Colors.orange,
];

Future<String> getMainPage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? defaultName = prefs.getString('name');
  if (defaultName == null) {
    return TargetNames.studyStart;
  } else {
    return TargetNames.studyTab;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBStudyWork().init());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final mainPage = await getMainPage();
  runApp(MyApp(
    mainPage: mainPage,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({this.mainPage = TargetNames.studyStart, super.key});

  final String mainPage;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: TargetPages.list,
      initialRoute: mainPage,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
