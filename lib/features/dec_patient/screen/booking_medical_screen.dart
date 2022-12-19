import 'dart:typed_data';

import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:admin_clinical/features/dec_patient/widgets/dp_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/utils.dart';
import '../../../services/data_service/data_service.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../widgets/dp_booking_appointment.dart';
import '../widgets/dp_create_id_tap.dart';

class BookingMedicalScreen extends StatelessWidget {
  final Function(int) switchPage;
  BookingMedicalScreen({super.key, required this.switchPage});
  PageController? pageController = PageController();
  // final controller = Get.put()
  void switchPage1(int index) {
    pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: constraints.maxWidth / 1.5,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(top: 100.0, bottom: 40.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor,
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10.0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/app_icon.png',
                      color: AppColors.primaryColor,
                      width: 60,
                      height: 60,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                        children: [
                          TextSpan(
                              text: ' Booking An Appointment ',
                              style: TextStyle(color: AppColors.primaryColor)),
                          TextSpan(
                              text: 'Form',
                              style: TextStyle(
                                  color: Color.fromARGB(51, 5, 70, 101))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                        title: 'Create ID', onPressed: () => switchPage1(0)),
                    const SizedBox(width: 10.0),
                    CustomButton(
                        title: 'Booking', onPressed: () => switchPage1(1)),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DpCreateIdTab(
                            height: constraints.maxHeight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DpBookingAppointmentTab(
                            height: constraints.maxHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
