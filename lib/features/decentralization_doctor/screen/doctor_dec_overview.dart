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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: const [
                FieldOverviewDoctor(),
                ListPatientField(),
              ],
            ),
          ),
          CalenderScheduleField(),
        ],
      );
    });
  }
}
