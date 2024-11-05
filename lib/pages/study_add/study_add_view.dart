import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_work/main.dart';
import 'package:study_work/widgets/study_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import 'study_add_logic.dart';

class StudyAddPage extends GetView<StudyAddLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isAdd ? 'Add task' : 'Edit task'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<StudyAddLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: <Widget>[
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Type',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: IgnorePointer(
                              ignoring: true,
                              child: StudyTextField(
                                  value: taskTypes[controller.type],
                                  hintText: 'Select type',
                                  textAlign: TextAlign.right,
                                  onChange: (value) {}))),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                        color: Colors.grey,
                      )
                    ].toRow(),
                  ),
                  onTap: () {
                    controller.typeSelected(context);
                  },
                ),
                SizedBox(
                  height: 40,
                  child: <Widget>[
                    const Text(
                      'Title',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: StudyTextField(
                            hintText: 'Enter title',
                            value: controller.title,
                            maxLength: 25,
                            onChange: (value) {
                              controller.title = value;
                            }))
                  ].toRow(),
                ),
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Maturity time',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: IgnorePointer(
                        ignoring: true,
                        child: StudyTextField(
                            textAlign: TextAlign.right,
                            hintText: 'Please select',
                            value: controller.endDateStr,
                            textStyle:
                                TextStyle(color: primaryColor, fontSize: 15),
                            onChange: (value) {}),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 20,
                        color: Colors.grey,
                      )
                    ].toRow(),
                  ),
                  onTap: () {
                    controller.selectedTime(context);
                  },
                ),
                SizedBox(
                    height: 40,
                    child: <Widget>[
                      const Text(
                        'Task color',
                        style: TextStyle(fontSize: 15),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 24,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, mainAxisSpacing: 10),
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Obx(() {
                                        return Visibility(
                                          visible: index ==
                                              controller
                                                  .selectedColorIndex.value,
                                          child: Image.asset(
                                            'assets/photoSelected.webp',
                                            width: 12,
                                            height: 12,
                                          ),
                                        );
                                      }),
                                    ).decorated(
                                        color: taskColors[index],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onTap: () {
                                      controller.selectedColorIndex.value =
                                          index;
                                    },
                                  );
                                }),
                          ),
                        ),
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                      .decorated(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12))
                      .marginOnly(top: 30),
                  onTap: () {
                    controller.commit(context);
                  },
                )
              ].toColumn(
                  separator: Divider(
                height: 15,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
          );
        }).marginAll(12),
      ),
    );
  }
}
