import 'package:admin_clinical/features/decentralization_doctor/controller/doctor_overview_controller.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter/material.dart';

import '../widgets/list_field/calender_schedule_field.dart';
import '../widgets/list_field/field_overview_doctor.dart';
import '../widgets/list_field/list_patient_field.dart';

DateTime now = DateTime.now();

// ignore: must_be_immutable
class DoctorDecOverview extends StatelessWidget {
  DoctorDecOverview({super.key});

  CalendarFormat format = CalendarFormat.month;
  final controller = Get.find<DoctorOverviewController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return PageView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    FieldOverviewDoctor(),
                    ListPatientField(),
                  ],
                ),
              ),
              CalenderScheduleField(),
            ],
          ),
        ],
      );
    });
  }
}
