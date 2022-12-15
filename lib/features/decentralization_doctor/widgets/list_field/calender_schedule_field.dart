import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../controller/doctor_overview_controller.dart';
import '../../controller/event.dart';
import '../../screen/doctor_dec_overview.dart';
import '../calender_schedule.dart';
import '../medical_of_doctor_today.dart';

class CalenderScheduleField extends StatelessWidget {
  CalenderScheduleField({
    Key? key,
  }) : super(key: key);
  final controller = Get.find<DoctorOverviewController>();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime focusedDay = DateTime.now();
  List<Event> getEventsfromDay(DateTime date) {
    String time = '${date.year}/${date.month}/${date.day}';
    return controller.lEvent[time] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calender',
              style: TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            const SizedBox(height: 20.0),
            Obx(
              () => CalenderSchedule(
                selectedDay: selectedDay.value,
                lEvent: getEventsfromDay,
                onDaySelected: (selectDay, focusDay) {
                  String time =
                      '${selectDay.year}/${selectDay.month}/${selectDay.day}';
                  controller.sEvent.value = controller.lEvent[time] ?? [];
                  selectedDay.value = selectDay;
                },
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                const Text(
                  'Up comming',
                  style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Obx(
              () => Expanded(
                child: ListView(
                  children: [
                    ...controller.sEvent.map(
                      (e) => MedicalOfDoctorToday(
                        image: "assets/images/doctor1.png",
                        patientName: e.description,
                        doctorName: AuthService.instance.user.name,
                        time: e.time,
                        status: e.type,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
