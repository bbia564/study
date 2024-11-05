import 'package:get/get.dart';
import 'package:study_work/db_study_work/db_study_work.dart';

import '../../db_study_work/study_entity.dart';

class StudyFirstLogic extends GetxController {

  final DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  var todayList = <StudyEntity>[].obs;
  var otherList = <StudyEntity>[].obs;

  void getData() async {
    var result = await dbStudyWork.getAllData();
    todayList.value = result.where((element) {
      final now = DateTime.now();
      return element.endTime.year == now.year && element.endTime.month == now.month && element.endTime.day == now.day;
    }).toList();
    otherList.value = result.where((element) {
      final now = DateTime.now();
      return element.endTime.year != now.year || element.endTime.month != now.month || element.endTime.day != now.day;
    }).toList();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

}
