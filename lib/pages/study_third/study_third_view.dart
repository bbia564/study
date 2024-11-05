import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'study_third_logic.dart';

class StudyThirdPage extends GetView<StudyThirdLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = ['Fill in data again','Delete initial record','About US'];
    return GestureDetector(
      child: Container(
        height: 40,
        color: Colors.transparent,
        child: <Widget>[
          Expanded(
              child: Text(
            titles[index],
            style: const TextStyle(fontSize: 15),
          )),
          index == 2 ? const Text('1.0.0').paddingOnly(right: 10) : const Icon(
            Icons.keyboard_arrow_right,
            size: 20,
          )
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      onTap: () {
        switch (index) {
          case 0:
            controller.showEditPersonInfo();
            break;
          case 1:
            controller.cleanAllData();
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0, context), _item(1, context)].toColumn(separator: Divider(
                height: 14,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(2, context)].toColumn(separator: Divider(
                height: 14,
                color: Colors.grey.withOpacity(0.3),
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(12))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
