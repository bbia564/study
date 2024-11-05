import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_work/main.dart';
import 'package:study_work/pages/study_second/all/all_view.dart';
import 'package:study_work/pages/study_second/study/study_view.dart';
import 'package:study_work/pages/study_second/work/work_view.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../widgets/indicator.dart';
import 'study_second_logic.dart';

class StudySecondPage extends StatefulWidget {
  const StudySecondPage({Key? key}) : super(key: key);

  @override
  State<StudySecondPage> createState() => _StudySecondPageState();
}

class _StudySecondPageState extends State<StudySecondPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(StudySecondLogic());

  late TabController _tabController;
  int touchedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    controller.getData();
    _tabController.addListener(() {
      controller.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        actions: [
          GestureDetector(
            child: Icon(
              Icons.add_circle,
              size: 30,
              color: primaryColor,
            ).marginOnly(right: 20),
            onTap: () {
              Get.toNamed('/study_add')?.then((_) {
                controller.getData();
              });
            },
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<StudySecondLogic>(builder: (_) {
          return SafeArea(
              child: <Widget>[
            Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    height: 200,
                    child: controller.chartsList.isEmpty
                        ? const Center(
                            child: Text('No data'),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 35,
                                    sections: showingSections(),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.chartsList
                                      .map((e) => Indicator(
                                            color:
                                                taskColors[e.first.colorIndex],
                                            text: taskTypes[e.first.type],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ))
                .decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
            SizedBox(
              width: double.infinity,
              child: Theme(
                data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    useMaterial3: true,
                    tabBarTheme:
                        const TabBarTheme(indicatorColor: Colors.transparent)),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor),
                  tabs: const [
                    SizedBox(
                        width: 81,
                        height: 32,
                        child: Tab(
                          text: "All",
                        )),
                    SizedBox(
                        width: 81,
                        height: 32,
                        child: Tab(
                          text: "Work",
                        )),
                    SizedBox(
                        width: 81,
                        height: 32,
                        child: Tab(
                          text: "Study",
                        ))
                  ],
                ),
              ),
            ).marginSymmetric(vertical: 10),
            Expanded(
                child: Container(
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllPage(controller.allList),
                  WorkPage(controller.workList),
                  StudyPage(controller.studyList)
                ],
              ),
            ))
          ].toColumn().marginAll(15));
        }),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    if (controller.chartsList.isEmpty) {
      return [];
    }
    int allNum = controller.chartsList.map((e) => e.length).reduce((a, b) {
      return a + b;
    });

    return List.generate(controller.chartsList.length, (i) {
      var item = controller.chartsList[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 11.0 : 9.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: taskColors[item.first.colorIndex],
        value: item.length.toDouble() / allNum * 100,
        title:
            '${taskTypes[item.first.type]}${(item.length.toDouble() / allNum * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
