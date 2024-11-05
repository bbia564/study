import 'package:get/get.dart';

import 'study_third_logic.dart';

class StudyThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudyThirdLogic());
  }
}
