import 'package:appifylab_task/components/auth_gate.dart';
import 'package:appifylab_task/constraints/theme_data_default.dart';
import 'package:appifylab_task/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  Get.put(AuthController());
  runApp(const EazyCourses());
}

class EazyCourses extends StatelessWidget {
  const EazyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      theme: ezycourseTheme,
      home: const AuthGate(),
    );
  }
}
