import 'package:get/get.dart';

import 'work_logic.dart';

class WorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkLogic());
  }
}
