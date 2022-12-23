import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:admin_clinical/features/dec_patient/screen/booking_medical_screen.dart';
import 'package:admin_clinical/features/dec_patient/screen/dp_view_all_doctor_screen.dart';
import 'package:admin_clinical/features/dec_patient/widgets/dp_app_bar.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../patient/widgets/custom_text_form_field.dart';
import '../widgets/field/bottom_field.dart';
import '../widgets/field/doctor_view_field.dart';
import '../widgets/field/dp_about_field.dart';
import '../widgets/field/dp_home_field.dart';
import '../widgets/field/dp_image_field.dart';
import '../widgets/field/text_des_field.dart';

List<IconData> listIcon = [
  FontAwesomeIcons.facebook,
  FontAwesomeIcons.twitter,
  FontAwesomeIcons.instagram,
  FontAwesomeIcons.youtube,
  FontAwesomeIcons.message,
];

List<Map<String, dynamic>> listIconTitleRow = [
  {
    'icon': Icons.location_pin,
    'title': ' 35/37 Rohtak Road, West Punjabi Bagh New Delhi – 110026'
  },
  {'icon': Icons.mail, 'title': ' info@mgshospital.com'},
  {'icon': Icons.phone, 'title': ' +91 11 4511 1444'},
];

List<String> listServices = [
  'Patient Care',
  'Ambulance Services',
  'Intensive Care Services',
  'Laboratory Services',
  'Imaging Services',
  '24 Hrs Services',
];
List<String> listAboutMgs = [
  'About Organization',
  'Chairman\'s Message',
  'Doctors',
  'Career',
  'Blogs',
  'Contact us',
];

class DpHomeScreen extends StatelessWidget {
  DpHomeScreen({super.key});
  final controller = Get.put(DpPatinetController());
  PageController? pageController = PageController();
  // final controller = Get.put()
  void switchPage(int index) {
    pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  RxInt checkPage = 0.obs;
  RxBool checkShadow = true.obs;
  RxBool checkShadow1 = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackgroundCOlor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.all(20.0),
          child: DpApBar(
            switchPage: switchPage,
            nexxPageCallback: () {
              checkPage.value = 0;
              switchPage(1);
            },
            openHealthRecordViewCallback: () {
              checkShadow.value = false;
              Future.delayed(const Duration(milliseconds: 400))
                  .then((value) => checkShadow1.value = false);
            },
          ),
        ),
      ),
      body: Obx(
        () => PageView(
          controller: pageController,
          children: [
            HomePage(
              swithcPage: switchPage,
              callNextPage: () {
                checkPage.value = 1;
                switchPage(1);
              },
              checkShadow1: checkShadow1.value,
              checkShadow: checkShadow.value,
              removeShadowCallback: () {
                controller.idPatinetSearchController.clear();
                controller.listHealthRecordSearch.clear();
                checkShadow.value = true;
                checkShadow1.value = true;
              },
            ),
            (checkPage.value == 0)
                ? BookingMedicalScreen(switchPage: switchPage)
                : DpViewAllDoctor(
                    callNextPage: () {
                      checkPage.value = 0;
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
