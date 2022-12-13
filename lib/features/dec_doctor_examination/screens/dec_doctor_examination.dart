import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class DecDoctorExamination extends StatelessWidget {
  DecDoctorExamination({super.key});
  RxInt check = 0.obs;
  RxInt showViewMessIndex = 0.obs;
  RxBool checkAnimation = true.obs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => AnimatedContainer(
                    height: checkAnimation.value
                        ? constraints.maxHeight * 3 / 5 - 10
                        : 100,
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10.0),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Examination View',
                                style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                )),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: Obx(
                            () => ListView(
                              children: [
                                for (int i = 0; i < 10; i++)
                                  MailItem(
                                    headerTitle: "File 1",
                                    id: 'Patient So 1',
                                    title:
                                        'Hey minhunsocute!A third Party will adsad',
                                    time: DateTime.now(),
                                    index: 1,
                                    groupValue: check.value,
                                    press: () => check.value = i,
                                    func: (value) {
                                      check.value = 0;
                                    },
                                    check: false,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: checkAnimation.value
                        ? constraints.maxHeight * 2 / 5 - 10
                        : constraints.maxHeight - 120,
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Your Examination',
                                style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                )),
                            const Spacer(),
                            InkWell(
                              onTap: () =>
                                  checkAnimation.value = !checkAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: checkAnimation.value
                              ? Row(
                                  children: const [
                                    ExaminationItem(),
                                    ExaminationItem(),
                                    ExaminationItem(),
                                    ExaminationItem(),
                                  ],
                                )
                              : ListView(
                                  children: [
                                    RowExaminationItem(
                                        examId: "Examination Id 1",
                                        patientName: "Nguyen Minh Hung",
                                        time: DateTime.now()),
                                    RowExaminationItem(
                                        examId: "Examination Id 2",
                                        patientName: "Truong Huynh Duc Hoang",
                                        time: DateTime.now()),
                                    RowExaminationItem(
                                        examId: "Examination Id 3",
                                        patientName: "Nguyen Trung Hieu",
                                        time: DateTime.now()),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Examination Overview',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class RowExaminationItem extends StatelessWidget {
  final String examId;
  final String patientName;
  final DateTime time;
  const RowExaminationItem({
    Key? key,
    required this.examId,
    required this.patientName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10.0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            'assets/images/pdf.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              examId,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              patientName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              DateFormat().add_yMEd().format(DateTime.now()),
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.more_horiz,
                color: AppColors.headline1TextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExaminationItem extends StatelessWidget {
  const ExaminationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 200,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        // border: Border.all(width: 2, color: AppColors.primaryColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/pdf.png',
                height: 50.0,
                width: 50.0,
              ),
              const Spacer(),
              Container(
                height: 10.0,
                width: 10.0,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'Exmaination Id 1',
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            DateFormat().add_yMMMEd().format(DateTime.now()),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 30.0,
            width: double.infinity,
            child: CustomButton(
              onTap: () {},
              text: "Check",
            ),
          ),
        ],
      ),
    );
  }
}

class MailItem extends StatelessWidget {
  final String headerTitle;
  final String id;
  final String title;
  final DateTime time;
  final int index;
  final int groupValue;
  final bool check;
  final Function(int?) func;
  final Function() press;
  MailItem(
      {super.key,
      required this.headerTitle,
      required this.id,
      required this.title,
      required this.time,
      required this.index,
      required this.groupValue,
      required this.func,
      required this.press,
      required this.check});
  RxBool onIt = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: press,
        onHover: ((value) => onIt.value = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: check
                ? AppColors.primaryColor[300]
                : onIt.value
                    ? AppColors.primaryColor[300]
                    : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: onIt.value ? Colors.black12 : Colors.white,
                  blurRadius: 10.0),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: onIt.value ? 35.0 : 30.0,
                width: onIt.value ? 35.0 : 30.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/doctor1.png')),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3.0),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  headerTitle,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: check
                        ? Colors.white
                        : onIt.value
                            ? Colors.white
                            : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  id,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: check
                        ? Colors.white
                        : onIt.value
                            ? Colors.white
                            : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  DateFormat().add_yMEd().format(time),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: check
                        ? Colors.white
                        : onIt.value
                            ? Colors.white
                            : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.more_horiz,
                    color: check
                        ? Colors.white
                        : onIt.value
                            ? Colors.white
                            : AppColors.headline1TextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
