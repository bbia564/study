import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_work/main.dart';
import 'package:study_work/target/target_names.dart';
import 'package:study_work/widgets/study_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

class StartAlert extends StatefulWidget {
  const StartAlert({this.name = '',this.indexSelected = 0,Key? key}) : super(key: key);
  final String name;
  final int indexSelected;

  @override
  State<StartAlert> createState() => _StartAlertState();
}

class _StartAlertState extends State<StartAlert> {
  var indexSelected = 0;
  String name = '';
  bool firstAdd = true;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.name.isNotEmpty) {
      firstAdd = false;
    }
    name = widget.name;
    indexSelected = widget.indexSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: <Widget>[
        const Text(
          'Select avatar',
          style: TextStyle(fontSize: 16),
        ).marginOnly(bottom: 10),
        SizedBox(
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemCount: 4,
              itemBuilder: (_, index) {
                return LayoutBuilder(builder: (_, c) {
                  return GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(c.maxHeight / 2),
                      child: Stack(
                        children: [
                          Image.asset('assets/photo$index.webp',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity),
                          Visibility(
                            visible: indexSelected == index,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                'assets/photoSelected.webp',
                                width: 20,
                                height: 20,
                              ),
                            ).decorated(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.circular(c.maxHeight / 2)),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        indexSelected = index;
                      });
                    },
                  );
                });
              }),
        ).marginOnly(bottom: 10),
        const Text(
          'Nickname',
          style: TextStyle(fontSize: 16),
        ).marginOnly(bottom: 10),
        Container(
          width: double.infinity,
          height: 50,
          child: StudyTextField(
              hintText: 'Enter nickname',
              value: name,
              maxLength: 15,
              onChange: (value) {
                name = value;
              }),
        )
            .decorated(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8))
            .marginOnly(bottom: 20),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: const Text(
              'Verify',
              style: TextStyle(color: Colors.white),
            ),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(8)),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            if (name.isEmpty) {
              Fluttertoast.showToast(msg: 'Enter nickname');
              return;
            }
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('indexSelected', indexSelected);
            await prefs.setString('name', name);
            if (firstAdd) {
              Get.offAndToNamed(TargetNames.studyTab);
            } else {
              Get.back();
            }
          },
        )
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ).decorated(color: Colors.white, borderRadius: BorderRadius.circular(12));
  }
}
