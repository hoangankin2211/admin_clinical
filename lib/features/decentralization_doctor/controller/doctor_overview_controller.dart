import 'package:get/get.dart';

import '../screen/doctor_dec_overview.dart';

class DoctorOverviewController extends GetxController {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime now = DateTime.now();

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
  List<Event> getEventsfromDay(DateTime date) {
    String time = '${date.year}/${date.month}/${date.day}';
    return selectedEvents[time] ?? [];
  }
}

class Event {
  final String title;
  final int type;
  final String description;
  final String location;
  final DateTime time;
  Event(
      {required this.type,
      required this.time,
      required this.description,
      required this.location,
      required this.title});
}
