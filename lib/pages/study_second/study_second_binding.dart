import 'package:get/get.dart';

import 'study_second_logic.dart';

class StudySecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudySecondLogic());
  }
}
