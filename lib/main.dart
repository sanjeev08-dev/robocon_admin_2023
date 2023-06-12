import 'dart:convert';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:robocon_admin_2023/helper/prefs.dart';
import 'package:robocon_admin_2023/public_detail/view.dart';
import 'package:robocon_admin_2023/schedule_meetings/view.dart';

import 'firebase_options.dart';
import 'helper/theme_data.dart';
import 'login/view.dart';
import 'logs/view.dart';

late Prefs prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = Prefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Widget widget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var uri = Uri.dataFromString(window.location.href);
    // var uri = Uri.parse(
    //     "https://ddrobocon-profile.web.app/?eyJlbWFpbCI6InNhbmplZXYwODEwOTdAZ21haWwuY29tIiwibmFtZSI6IjAwMiJ9");
    if (uri.query.isNotEmpty) {
      String decoded = stringToBase64.decode(uri.query);
      if (decoded.startsWith("{")) {
        widget = PublicDetailView(
          email: jsonDecode(decoded)["email"],
          studentName: jsonDecode(decoded)["name"],
        );
      } else {
        widget = PublicDetailView(email: decoded);
      }
      // var map = Uri.splitQueryString(decoded);

    } else {
      // widget = const DataListView();
      widget = const LoginView();
      // widget = LogsView();
    }
    return GetMaterialApp(
      title: 'Robocon Admin 2023',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: widget,
    );
  }
}
