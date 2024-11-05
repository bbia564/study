import 'package:get/get.dart';

import '../study_first/study_first_logic.dart';
import '../study_second/study_second_logic.dart';
import '../study_third/study_third_logic.dart';
import 'study_tab_logic.dart';

class StudyTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyTabLogic());
    Get.lazyPut(() => StudyFirstLogic());
    Get.lazyPut(() => StudySecondLogic());
    Get.lazyPut(() => StudyThirdLogic());
  }
}
