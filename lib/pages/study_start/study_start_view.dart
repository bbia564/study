import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../widgets/start_alert.dart';
import 'study_start_logic.dart';

class StudyStartPage extends GetView<StudyStartLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                const Text(
                  'Initialize account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ).marginSymmetric(vertical: 30),
                const StartAlert().marginAll(12)
              ].toColumn(),
            )),
      ),
    );
  }
}
