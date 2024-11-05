import 'package:get/get.dart';
import 'package:study_work/db_study_work/db_study_work.dart';

import '../../db_study_work/study_entity.dart';

class Tuple2<A, B> {
  final A item1;
  final B item2;

  Tuple2(this.item1, this.item2);

  @override
  bool operator ==(Object other) =>
      other is Tuple2<A, B> &&
          other.item1 == item1 &&
          other.item2 == item2;

  @override
  int get hashCode => item1.hashCode ^ item2.hashCode;
}

class StudySecondLogic extends GetxController {

  final DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  var selectedIndex = 0;

  var allList = <StudyEntity>[];
  var workList = <StudyEntity>[];
  var studyList = <StudyEntity>[];
  var chartsList = <List<StudyEntity>>[];

  List<List<StudyEntity>> groupByTypeAndColorIndex(List<StudyEntity> entities) {
    Map<Tuple2<int, int>, List<StudyEntity>> grouped = {};

    for (var entity in entities) {
      var key = Tuple2(entity.type, entity.colorIndex);
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]?.add(entity);
    }
    return grouped.values.toList();
  }


  void getData() async {
    final result = await dbStudyWork.getAllData();
    allList = result;
    workList = result.where((element) => element.type == 0).toList();
    studyList = result.where((element) => element.type == 1).toList();
    chartsList = groupByTypeAndColorIndex(result);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
