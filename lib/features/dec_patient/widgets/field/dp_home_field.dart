import 'package:admin_clinical/features/dec_patient/widgets/field/text_des_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/dp_patinet_contnrolller.dart';
import '../view_all_health_record.dart';
import 'bottom_field.dart';
import 'doctor_view_field.dart';
import 'dp_about_field.dart';
import 'dp_image_field.dart';

class HomePage extends StatelessWidget {
  final Function(int) swithcPage;
  final Function() callNextPage;
  final bool checkShadow;
  final bool checkShadow1;
  final Function() removeShadowCallback;
  HomePage({
    Key? key,
    required this.swithcPage,
    required this.callNextPage,
    required this.checkShadow,
    required this.checkShadow1,
    required this.removeShadowCallback,
  }) : super(key: key);
  final controller = Get.find<DpPatinetController>();
  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(children: [
              SizedBox(
                width: Get.width,
                height: Get.height,
                child: Row(
                  children: const [
                    TextDesField(),
                    ImageField(),
                  ],
                ),
              ),
              const AboutField(),
              DoctorViewField(
                nextPageCallback: callNextPage,
              ),
              const BottomField(),
            ]),
          ),
          InkWell(
            onTap: removeShadowCallback,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: checkShadow ? 0 : widthDevice,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.black54,
                ],
              )),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(40.0),
              curve: Curves.fastOutSlowIn,
              width: checkShadow1 ? 0 : widthDevice / 4,
              height: heightDevice - 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: ViewAllHealthRecord(
                  widthDevice: widthDevice, controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
