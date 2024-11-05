import 'package:get/get.dart';

import '../../../db_study_work/db_study_work.dart';

class WorkLogic extends GetxController {

  final DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  getData() async {
    final result = await dbStudyWork.getAllData();
    final list = result.where((element) => element.type == 0).toList();
    return list;
  }

}
