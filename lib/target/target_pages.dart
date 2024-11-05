import 'package:get/get.dart';
import 'package:study_work/pages/study_first/study_first_binding.dart';
import 'package:study_work/pages/study_first/study_first_view.dart';
import 'package:study_work/pages/study_start/study_start_binding.dart';
import 'package:study_work/pages/study_tab/study_tab_binding.dart';
import 'package:study_work/pages/study_tab/study_tab_view.dart';
import 'package:study_work/target/target_names.dart';

import '../pages/study_add/study_add_binding.dart';
import '../pages/study_add/study_add_view.dart';
import '../pages/study_second/study_second_binding.dart';
import '../pages/study_second/study_second_view.dart';
import '../pages/study_start/study_start_view.dart';
import '../pages/study_third/study_third_binding.dart';
import '../pages/study_third/study_third_view.dart';

class TargetPages {

  static pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: page,
      binding: binding,
      preventDuplicates: true,
      transition: Transition.cupertino,
      popGesture: true,
    );
  }


  static List<GetPage> list = [
    pageBuilder(name: TargetNames.studyStart, page: () => StudyStartPage(),binding: StudyStartBinding()),
    pageBuilder(name: TargetNames.studyTab, page: () => StudyTabPage(),binding: StudyTabBinding()),
    pageBuilder(name: TargetNames.studyFirst, page: () => StudyFirstPage(),binding: StudyFirstBinding()),
    pageBuilder(name: TargetNames.studySecond, page: () => const StudySecondPage(),binding: StudySecondBinding()),
    pageBuilder(name: TargetNames.studyThird, page: () => StudyThirdPage(),binding: StudyThirdBinding()),
    pageBuilder(name: TargetNames.studyAdd, page: () => StudyAddPage(),binding: StudyAddBinding()),
  ];
}