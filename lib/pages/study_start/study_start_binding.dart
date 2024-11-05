import 'package:get/get.dart';

import 'study_start_logic.dart';

class StudyStartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyStartLogic());
  }
}
