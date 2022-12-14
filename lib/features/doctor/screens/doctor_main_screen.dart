import 'package:admin_clinical/features/doctor/controller/doctor_main_controller.dart';
import 'package:admin_clinical/features/doctor/screens/view_all_doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'doctor_overview_screen.dart';

// ignore: must_be_immutable
class DoctorMainScreen extends StatelessWidget {
  DoctorMainScreen({super.key});
  RxInt checkPage = 0.obs;
  final controller = Get.find<DoctorMainController>();
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  void onButtonTape(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listView = [
      DoctorOverView(
        tapNextPage: () => checkPage.value = 1,
      ),
      ViewAllDoctor(
        tapBackPage: () => checkPage.value = 0,
      ),
    ];

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => listView[checkPage.value]));
  }
}
