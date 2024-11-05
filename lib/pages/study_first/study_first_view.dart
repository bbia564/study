import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_work/pages/study_first/first_item.dart';
import 'package:styled_widget/styled_widget.dart';

import 'study_first_logic.dart';

class StudyFirstPage extends StatefulWidget {
  const StudyFirstPage({Key? key}) : super(key: key);

  @override
  State<StudyFirstPage> createState() => _StudyFirstPageState();
}

class _StudyFirstPageState extends State<StudyFirstPage> {
  StudyFirstLogic controller = Get.put(StudyFirstLogic());

  var name = '-'.obs;
  var indexSelected = 0.obs;
  var goodString = '-'.obs;

  void getDefaultPersonInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    indexSelected.value = prefs.getInt('indexSelected') ?? 0;
    final now = DateTime.now();
    if (now.hour > 5 && now.hour < 12) {
      goodString.value = 'Good morning!';
    } else if (now.hour >= 12 && now.hour <= 18) {
      goodString.value = 'Good afternoon!';
    } else {
      goodString.value = 'Good evening!';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDefaultPersonInfo();
    super.initState();
  }

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
              <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Obx(() {
                    return Image.asset(
                      'assets/photo$indexSelected.webp',
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                    );
                  }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: <Widget>[
                    Obx(() {
                      return Text(
                        goodString.value,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      );
                    }),
                    Obx(() {
                      return Text(
                        name.value,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      );
                    })
                  ].toColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start),
                )
              ].toRow(),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  <Widget>[
                    Image.asset(
                      'assets/todayTask.webp',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Today task',
                      style: TextStyle(fontSize: 14),
                    )
                  ].toRow(),
                  Obx(() {
                    return controller.todayList.value.isEmpty
                        ? const SizedBox(
                            height: 80,
                            child: Center(
                              child: Text('No data'),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: controller.todayList.value.length,
                            itemBuilder: (_, index) {
                              var entity = controller.todayList.value[index];
                              return GestureDetector(
                                child: FirstItem(
                                  entity,
                                  statusOnTap: () async {
                                    entity.isDone = entity.isDone == 0 ? 1 : 0;
                                    await controller.dbStudyWork
                                        .updateAlarm(entity);
                                    controller.getData();
                                  },
                                ),
                                onTap: () {
                                  Get.toNamed('/study_add',
                                          arguments: entity)
                                      ?.then((_) {
                                    controller.getData();
                                  });
                                },
                              );
                            });
                  })
                ].toColumn(),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  <Widget>[
                    Image.asset(
                      'assets/otherTask.webp',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'The next task',
                      style: TextStyle(fontSize: 14),
                    )
                  ].toRow(),
                  Obx(() {
                    return controller.otherList.value.isEmpty
                        ? const SizedBox(
                            height: 80,
                            child: Center(
                              child: Text('No data'),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: controller.otherList.value.length,
                            itemBuilder: (_, index) {
                              var entity = controller.otherList.value[index];
                              return GestureDetector(
                                child: FirstItem(
                                  entity,
                                  statusOnTap: () async {
                                    entity.isDone = entity.isDone == 0 ? 1 : 0;
                                    await controller.dbStudyWork
                                        .updateAlarm(entity);
                                    controller.getData();
                                  },
                                ),
                                onTap: () {
                                  Get.toNamed('/study_add',
                                          arguments: entity)
                                      ?.then((_) {
                                    controller.getData();
                                  });
                                },
                              );
                            });
                  })
                ].toColumn(),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(12))
            ].toColumn(),
          ).marginAll(12),
        ),
      ),
    );
  }
}
