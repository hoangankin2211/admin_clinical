import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../constants/app_colors.dart';
import '../controller/event.dart';
import '../screen/doctor_dec_overview.dart';

class CalenderSchedule extends StatelessWidget {
  final DateTime selectedDay;
  // final   CalendarFormat format = CalendarFormat.month;
  final List<Event> Function(DateTime) lEvent;
  final Function(DateTime, DateTime) onDaySelected;

  const CalenderSchedule(
      {super.key,
      required this.selectedDay,
      required this.lEvent,
      required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(width: 1.0, color: AppColors.primaryColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
          ),
        ],
      ),
      child: TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,

        //Day Changed
        onDaySelected: onDaySelected,
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
        eventLoader: lEvent,

        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.redAccent[100],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          markerDecoration: const BoxDecoration(
              color: AppColors.primaryColor, shape: BoxShape.circle),
          selectedTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          todayDecoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.5),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          todayTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          defaultTextStyle: const TextStyle(
            color: AppColors.headline1TextColor,
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        headerStyle: HeaderStyle(
          leftChevronIcon: const Icon(Icons.chevron_left,
              color: AppColors.headline1TextColor),
          rightChevronIcon: const Icon(Icons.chevron_right,
              color: AppColors.headline1TextColor),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: Colors.redAccent[100],
            borderRadius: BorderRadius.circular(5.0),
          ),
          formatButtonTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // daysOfWeekStyle: TextStyle(),
      ),
    );
  }
}
