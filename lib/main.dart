import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_work/db_study_work/db_study_work.dart';
import 'package:study_work/pages/study_add/study_add_binding.dart';
import 'package:study_work/pages/study_add/study_add_view.dart';
import 'package:study_work/pages/study_first/study_first_binding.dart';
import 'package:study_work/pages/study_first/study_first_view.dart';
import 'package:study_work/pages/study_mero/study_more_binding.dart';
import 'package:study_work/pages/study_mero/study_more_view.dart';
import 'package:study_work/pages/study_second/study_second_binding.dart';
import 'package:study_work/pages/study_second/study_second_view.dart';
import 'package:study_work/pages/study_start/study_start_binding.dart';
import 'package:study_work/pages/study_start/study_start_view.dart';
import 'package:study_work/pages/study_tab/study_tab_binding.dart';
import 'package:study_work/pages/study_tab/study_tab_view.dart';
import 'package:study_work/pages/study_third/study_third_binding.dart';
import 'package:study_work/pages/study_third/study_third_view.dart';
import 'package:study_work/widgets/check_alert.dart';

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
    return '/study_start';
  } else {
    return '/study_tab';
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
  const MyApp({this.mainPage = '/study_start', super.key});

  final String mainPage;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Lops,
      initialRoute: '/',
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

List<GetPage<dynamic>> Lops = [
  GetPage(name: '/', page: () => const StudyMoreView(),binding: StudyMoreBinding()),
  GetPage(name: '/study_start', page: () => StudyStartPage(),binding: StudyStartBinding()),
  GetPage(name: '/study_tab', page: () => StudyTabPage(),binding: StudyTabBinding()),
  GetPage(name: '/study_check', page: () => const CheckAlert()),
  GetPage(name: '/study_first', page: () => const StudyFirstPage(),binding: StudyFirstBinding()),
  GetPage(name: '/study_second', page: () => const StudySecondPage(),binding: StudySecondBinding()),
  GetPage(name: '/study_third', page: () => StudyThirdPage(),binding: StudyThirdBinding()),
  GetPage(name: '/study_add', page: () => StudyAddPage(),binding: StudyAddBinding()),
];
