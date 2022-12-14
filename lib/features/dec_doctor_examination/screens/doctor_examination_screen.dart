import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/doctor_examination_controller.dart';

// ignore: must_be_immutable
class DoctorExaminationScreen extends StatelessWidget {
  DoctorExaminationScreen({super.key});

  final doctorExaminationController = Get.find<DoctorExaminationController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => PageView(
        controller: doctorExaminationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: doctorExaminationController.pages,
      ),
    );
  }
}
