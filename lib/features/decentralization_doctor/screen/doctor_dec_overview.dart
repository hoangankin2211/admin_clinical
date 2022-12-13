import 'dart:html';
import 'dart:js';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../overview/widgets/medical_today.dart';
import '../widgets/calender_schedule.dart';
import '../widgets/item_one.dart';
import '../widgets/list_field/calender_schedule_field.dart';
import '../widgets/list_field/field_overview_doctor.dart';
import '../widgets/list_field/list_patient_field.dart';
import '../widgets/list_patient_item.dart';
import '../widgets/medical_of_doctor_today.dart';
import '../widgets/row_consulation_item.dart';

DateTime now = DateTime.now();

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
                FieldOverivewDoctor(),
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
