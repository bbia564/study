import 'package:get/get.dart';

import 'study_more_logic.dart';

class StudyMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
