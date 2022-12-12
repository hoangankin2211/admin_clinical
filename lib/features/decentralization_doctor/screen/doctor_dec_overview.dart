import 'dart:html';
import 'dart:js';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../overview/widgets/medical_today.dart';

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

DateTime now = DateTime.now();

class DoctorDecOverview extends StatelessWidget {
  DoctorDecOverview({super.key});
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
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<Event> getEventsfromDay(DateTime date) {
    String time = '${date.year}/${date.month}/${date.day}';
    return selectedEvents[time] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _field1(),
                _listPatientField(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
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
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        // setState(() {
                        //   format = _format;
                        // });
                      },
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,

                      //Day Changed
                      onDaySelected: (DateTime selectDay, DateTime focusDay) {
                        // setState(() {
                        //   selectedDay = selectDay;
                        //   focusedDay = focusDay;
                        // });
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(selectedDay, date);
                      },
                      eventLoader: getEventsfromDay,

                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Colors.redAccent[100],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        markerDecoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle),
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
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
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
          ),
        ],
      );
    });
  }

  Expanded _listPatientField() {
    return Expanded(
      flex: 7,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(
            top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Patient List',
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Row(
                          children: const [
                            Text(
                              "Week ",
                              style: TextStyle(
                                color: AppColors.primarySecondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down,
                                color: AppColors.primarySecondColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListPatientItem(
                            image: AuthService.instance.user.avt,
                            name: "Nguyen Minh Hung",
                            time: 9,
                            press: () {},
                            check: true),
                        ListPatientItem(
                            image: AuthService.instance.user.avt,
                            name: "Truong Huynh Duc Hoang",
                            time: 10,
                            press: () {},
                            check: false),
                        ListPatientItem(
                            image: AuthService.instance.user.avt,
                            name: "Nguyen Trung Hieu",
                            time: 20,
                            press: () {},
                            check: false),
                        ListPatientItem(
                            image: AuthService.instance.user.avt,
                            name: "Phan Thien Nhan",
                            time: 12,
                            press: () {},
                            check: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Consulation',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 7.0)
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AuthService.instance.user.avt),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nguyen Minh Hung',
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    Text(
                                      'Male - 28 years 3 Months',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Medical Form',
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 170, 217, 255),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text(
                                  'Today 10:00 AM',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  children: const [
                                    Text(
                                      'Check',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Icon(Icons.arrow_right, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10.0),
                          const RowConsultationItem(
                            header: 'Last Checked: ',
                            title:
                                'Dr Everly on 21 April 2021 Prescription #2J983KTO',
                          ),
                          const RowConsultationItem(
                            header: 'Observation: ',
                            title:
                                'Hight Fever and cough at normal hemoglobin levels',
                          ),
                          const RowConsultationItem(
                            header: 'Prescription: ',
                            title:
                                'Pracetamol - 2 times a day, Dizopam - Day and Night before meal Wikory!',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _field1() {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15.0),
              const Text(
                'Good Morning ',
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0),
              ),
              Text(
                'Dr.${AuthService.instance.user.name}',
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor[300]!,
                          Colors.deepPurple[400]!,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Khach da kham',
                                  style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                                const Text(
                                  '104',
                                  style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70.0,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Item1(
                                        header: "New Patients",
                                        data: 40,
                                        check: true,
                                        data1: 30),
                                    SizedBox(width: 20),
                                    Item1(
                                      header: "Old Patients",
                                      data: 30,
                                      check: false,
                                      data1: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: constraints.maxHeight - 20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(AuthService.instance.user.avt),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowConsultationItem extends StatelessWidget {
  final String header;
  final String title;
  const RowConsultationItem({
    Key? key,
    required this.header,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              header,
              style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListPatientItem extends StatelessWidget {
  final String image;
  final String name;
  final int time;
  final bool check;
  final Function() press;
  const ListPatientItem({
    Key? key,
    required this.image,
    required this.name,
    required this.time,
    required this.check,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: check
              ? const Color.fromARGB(255, 205, 233, 255)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 7.0)
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  const Text(
                    'Up Comming',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 170, 217, 255),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                '$time:00 AM',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  final String header;
  final int data;
  final bool check;
  final int data1;
  const Item1({
    Key? key,
    required this.header,
    required this.data,
    required this.check,
    required this.data1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 170, 217, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                data.toString(),
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: check ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Text(
                      '${data1.toString()}%',
                      style: TextStyle(
                          color: check ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MedicalOfDoctorToday extends StatelessWidget {
  final String image;
  final String patientName;
  final String doctorName;
  final DateTime time;
  final int status;
  const MedicalOfDoctorToday({
    Key? key,
    required this.image,
    required this.patientName,
    required this.doctorName,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Text(
                  '${DateFormat().add_yMEd().format(time)} | ${DateFormat().add_jm().format(time)}',
                  style: const TextStyle(
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (status == 0) ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
