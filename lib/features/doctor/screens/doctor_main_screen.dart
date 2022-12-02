import 'package:admin_clinical/constants/fake_data.dart';
import 'package:admin_clinical/constants/global_widgets/header_list_item.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:admin_clinical/features/doctor/controller/doctor_main_controller.dart';
import 'package:admin_clinical/features/doctor/screens/view_all_doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../widgets/top_doctor_card.dart';
import 'doctor_overview_screen.dart';

PageController pageController = PageController(initialPage: 0, keepPage: true);
void onButtonTape(int index) {
  pageController.animateToPage(index,
      duration: const Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
}

class DoctorMainScreen extends StatelessWidget {
  DoctorMainScreen({super.key});
  RxInt checkPage = 0.obs;
  final controller = Get.put(DoctorMainController());
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
