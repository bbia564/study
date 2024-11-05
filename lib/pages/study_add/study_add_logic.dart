import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_work/db_study_work/db_study_work.dart';
import 'package:study_work/db_study_work/study_entity.dart';
import 'package:study_work/main.dart';
import 'package:styled_widget/styled_widget.dart';

class StudyAddLogic extends GetxController {

  final DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  var type = 0;
  var title = '';
  DateTime? endDate;
  String endDateStr = '';
  var selectedColorIndex = 0.obs;
  StudyEntity? entity;
  bool isAdd = true;
  bool hadCommit = false;
  
  void commit(BuildContext context) async {
    if (title.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter title');
      return;
    }
    if (endDate == null) {
      Fluttertoast.showToast(msg: 'Select maturity time');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (hadCommit) {
      return;
    }
    if (!hadCommit) {
      hadCommit = true;
    }
    if (isAdd) {
      await dbStudyWork.dbBase.insert('study', {
        'created_time': DateTime.now().toIso8601String(),
        'type': type,
        'title': title,
        'end_time': endDate!.toIso8601String(),
        'color_index': selectedColorIndex.value,
        'is_done': 0,
      });
    } else {
      await dbStudyWork.dbBase.update(
          'study',
          {
            'type': type,
            'title': title,
            'end_time': endDate!.toIso8601String(),
            'color_index': selectedColorIndex.value,
            'is_done': entity!.isDone,
          },
          where: 'id = ?',
          whereArgs: [entity!.id]);
    }
    Get.back();

  }

  void typeSelected(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    var currentType = type;
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      height: 220,
      child: <Widget>[
        <Widget>[
          GestureDetector(
            child: const Text('Cancel'),
            onTap: () {
              Get.back();
            },
          ),
          GestureDetector(
            child: const Text('OK'),
            onTap: () {
              type = currentType;
              update();
              Get.back();
            },
          )
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .marginOnly(bottom: 20),
        Expanded(
            child: CupertinoPicker.builder(
              scrollController: FixedExtentScrollController(initialItem: currentType),
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                currentType = index;
                },
                childCount: 2,
                itemBuilder: (_, index) {
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      taskTypes[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }))
      ].toColumn(),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

  void selectedTime(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDatePicker(context,
        pickerMode: DateTimePickerMode.date,
        minDateTime: DateTime.now(),
        dateFormat: 'dd-MM-yyyy', onConfirm: (date, dateList) {
      endDate = date;
      endDateStr = DateFormat('dd-MM-yyyy').format(date);
      update();
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    entity = Get.arguments;
    if (entity != null) {
      isAdd = false;
      type = entity!.type;
      title = entity!.title;
      endDate = entity!.endTime;
      endDateStr = DateFormat('dd-MM-yyyy').format(entity!.endTime);
      selectedColorIndex.value = entity!.colorIndex;
      update();
    }
    super.onInit();
  }

}
