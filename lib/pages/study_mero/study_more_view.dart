import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'study_more_logic.dart';

class StudyMoreView extends GetView<PageLogic> {
  const StudyMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.bednar.value
              ? const CircularProgressIndicator(color: Colors.blue)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.dlryt();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
