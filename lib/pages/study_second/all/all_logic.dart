import 'package:get/get.dart';

import '../../../db_study_work/db_study_work.dart';

class AllLogic extends GetxController {

  final DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  getData() async {
    final result = await dbStudyWork.getAllData();
     return result;
  }

}
