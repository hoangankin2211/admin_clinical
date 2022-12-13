import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../controller/event.dart';
import '../../screen/doctor_dec_overview.dart';
import '../calender_schedule.dart';
import '../medical_of_doctor_today.dart';

class CalenderScheduleField extends StatelessWidget {
  CalenderScheduleField({
    Key? key,
  }) : super(key: key);

  late Map<String, List<Event>> selectedEvents = {
    '${now.year}/${now.month}/${now.day}': [
      Event(
        type: 0,
        time: DateTime.now(),
        description:
            'The final exam will be held at 7:30 am, in room A202 at the School of Natural Sciences',
        location: '',
        title: 'Windows Develop Exam',
      ),
      Event(
        type: 1,
        time: DateTime.now(),
        description: '',
        location: '',
        title: 'Special Day',
      ),
      Event(
        type: 2,
        time: DateTime.now(),
        description: '',
        location: ' Ho Chi Minh City, University of Sciece',
        title: 'IT Festival ',
      )
    ],
  };
  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime focusedDay = DateTime.now();
  List<Event> getEventsfromDay(DateTime date) {
    String time = '${date.year}/${date.month}/${date.day}';
    return selectedEvents[time] ?? [];
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
            Expanded(
              child: ListView(
                children: [
                  MedicalOfDoctorToday(
                      image: "assets/images/doctor1.png",
                      patientName: "Nguyen Minhh Hung",
                      doctorName: "Dr.Truong Huynh Duc Hoang",
                      time: DateTime.now(),
                      status: 0),
                  MedicalOfDoctorToday(
                      image: "assets/images/doctor2.png",
                      patientName: "Nguyen Trung Hieu",
                      doctorName: "Dr.Truong Huynh  Hoang",
                      time: DateTime.now(),
                      status: 1),
                  MedicalOfDoctorToday(
                      image: "assets/images/doctor3.png",
                      patientName: "Truong Huynh Duc Hoang",
                      doctorName: "Dr.Truong Huynh Duc ",
                      time: DateTime.now(),
                      status: 1),
                  MedicalOfDoctorToday(
                      image: "assets/images/fake_avatar.jpg",
                      patientName: "Nguyen Minhh Hung",
                      doctorName: "Dr.Truong Huynh Duc Hoang",
                      time: DateTime.now(),
                      status: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
