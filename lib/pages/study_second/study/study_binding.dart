import 'package:get/get.dart';

import 'study_logic.dart';

class StudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyLogic());
  }
}
