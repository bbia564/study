import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../db_study_work/study_entity.dart';
import '../../../target/target_names.dart';
import '../second_item.dart';
import 'study_logic.dart';

class StudyPage extends StatefulWidget {
  StudyPage(this.list,{Key? key}) : super(key: key);

  List<StudyEntity> list;

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyLogic>(init: StudyLogic(),builder: (controller) {
      return widget.list.isEmpty
          ? const Center(child: Text('No data'))
          : ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.list.length,
          itemBuilder: (_, index) {
            var entity = widget.list[index];
            return GestureDetector(
              child: SecondItem(
                entity,
                statusOnTap: () async {
                  entity.isDone = entity.isDone == 0 ? 1 : 0;
                  await controller.dbStudyWork.updateAlarm(entity);
                  widget.list = await controller.getData();
                  controller.update();
                },
              ),
              onTap: () {
                Get.toNamed(TargetNames.studyAdd, arguments: entity)
                    ?.then((_) async {
                  widget.list = await controller.getData();
                  controller.update();
                });
              },
            );
          });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}





