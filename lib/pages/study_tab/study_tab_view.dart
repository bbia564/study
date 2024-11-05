import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_work/main.dart';
import 'package:study_work/pages/study_first/study_first_logic.dart';
import 'package:study_work/pages/study_first/study_first_view.dart';
import 'package:study_work/pages/study_second/study_second_logic.dart';
import 'package:study_work/pages/study_second/study_second_view.dart';
import 'package:study_work/pages/study_third/study_third_view.dart';

import 'study_tab_logic.dart';

class StudyTabPage extends GetView<StudyTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          StudyFirstPage(),
          const StudySecondPage(),
          StudyThirdPage(),
        ],
      ),
      bottomNavigationBar: Obx(()=>_navSBars()),
    );
  }

  Widget _navSBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,color: Colors.grey.withOpacity(0.5)),
          activeIcon: Icon(Icons.home,color: primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task,color: Colors.grey.withOpacity(0.5)),
          activeIcon: Icon(Icons.task,color: primaryColor),
          label: 'Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.5)),
          activeIcon: Icon(Icons.settings,color: primaryColor),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
        if (index == 0) {
          StudyFirstLogic logic = Get.find<StudyFirstLogic>();
          logic.getData();
        } else if (index == 1) {
          StudySecondLogic logic = Get.find<StudySecondLogic>();
          logic.getData();
        }
      },
    );
  }
}
