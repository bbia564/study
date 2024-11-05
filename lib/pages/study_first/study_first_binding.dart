import 'package:get/get.dart';

import 'study_first_logic.dart';

class StudyFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyFirstLogic());
  }
}
