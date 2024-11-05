import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_work/pages/study_second/second_item.dart';

import '../../../db_study_work/study_entity.dart';
import '../../../target/target_names.dart';
import 'all_logic.dart';

class AllPage extends StatefulWidget {
  AllPage(this.list, {Key? key}) : super(key: key);

  List<StudyEntity> list;

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllLogic>(init: AllLogic(),builder: (controller) {
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
