import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_work/db_study_work/db_study_work.dart';
import 'package:study_work/widgets/start_alert.dart';

class StudyThirdLogic extends GetxController {

  DBStudyWork dbStudyWork = Get.find<DBStudyWork>();

  showEditPersonInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final indexSelected = prefs.getInt('indexSelected') ?? 0;
    Get.dialog(
        transitionDuration: const Duration(milliseconds: 100),
        AlertDialog(
          content: SizedBox(
              width: 300,
              height: 280,
              child: StartAlert(
                name: name,
                indexSelected: indexSelected,
              )),
        ));
  }

  cleanAllData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to delete all your data?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await dbStudyWork.cleanAllData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """),
        );
      },
    );
  }

  aboutUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 77,
        height: 77,
      ),
      children: [
        const Text(
            """We provide you with records of work and study assignments"""),
      ],
      context: context,
    );
  }
}
