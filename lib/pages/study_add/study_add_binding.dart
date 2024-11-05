import 'package:get/get.dart';

import 'study_add_logic.dart';

class StudyAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyAddLogic());
  }
}
