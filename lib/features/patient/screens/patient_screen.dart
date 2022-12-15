import 'dart:math';

import 'package:admin_clinical/constants/fake_data.dart';
import 'package:admin_clinical/constants/global_widgets/header_list_item.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../constants/app_colors.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 10.0),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'My Patient >> Consulation Note >>',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  ' Monitoring Plan',
                                  style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Monitoring Plan',
                              style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Clinic Consulation @Medsy',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              '11/07/2022 @ 11:11',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Dr.Sphen Conley',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'A negative test result only means that you did not have COVID at the time of testing.However, that does not mean you will not get Covid -19.0',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(height: 20.0),
                            const Text(
                              'Clinical Summary',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'An after-visit summary that prvides a patient with relvant and actionable inforamtion and instructions containing the patient name, providers\'s office contact information, date and location of visit, and updated medication list updated vitals, reason(s) for visit',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(height: 30.0),
                            const Text(
                              'Prescribed Monitoring Plan',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Stephen Cury (1 Month)',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              '11/07/2021',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Amount \$300',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: double.infinity,
                              child: Column(children: []),
                            ),
                            const Text(
                              "Medical History",
                              style: TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0),
                            ),
                            const SizedBox(height: 10.0),
                            const HeaderListItem(
                              titles: [
                                "ID",
                                "Medical",
                                "Doctor",
                                "Clinic Room",
                                "Date",
                                "Status"
                              ],
                              checkHeader: true,
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                  ...FakeData.fakeDataMedicalHistory.map(
                                    (e) => ListItem(
                                      checkHeader: true,
                                      widgets: [
                                        Text(
                                          e["id"].toString(),
                                          style: const TextStyle(
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e["Medical"].toString(),
                                          style: const TextStyle(
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e["Doctor"].toString(),
                                          style: const TextStyle(
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e["cr"].toString(),
                                          style: const TextStyle(
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          DateFormat()
                                              .add_yMd()
                                              .format(e["date"]),
                                          style: const TextStyle(
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5.0),
                                              decoration: BoxDecoration(
                                                color: e["status"] == 0
                                                    ? Colors.green
                                                        .withOpacity(0.2)
                                                    : Colors.red
                                                        .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Text(
                                                e["status"] == 0
                                                    ? "Completed"
                                                    : "Uncompleted",
                                                style: TextStyle(
                                                  color: e["status"] == 0
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40.0),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          // margin: const EdgeInsets.only(left: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.headline1TextColor
                                    .withOpacity(0.2),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20.0),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/fake_avatar.jpg',
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.headline1TextColor
                                          .withOpacity(0.2),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              const Text(
                                'Mr.Minh Hung',
                                style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0),
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                '22 Years, Male',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(height: 10.0),
                              const Divider(thickness: 0.6),
                              const SizedBox(height: 20.0),
                              const ProfileRow(
                                mainTitle: "Email",
                                title: 'hungnguyen.201102ak@gmail.com',
                              ),
                              const SizedBox(height: 25.0),
                              const ProfileRow(
                                mainTitle: "Phone",
                                title: '(704) 555-0127',
                              ),
                              const SizedBox(height: 25.0),
                              const ProfileRow(
                                mainTitle: "Date of Birth",
                                title: '14 February 2001',
                              ),
                              const SizedBox(height: 25.0),
                              const ProfileRow(
                                mainTitle: "Diseases",
                                title: 'Cardiology',
                              ),
                              const SizedBox(height: 20.0),
                              const Divider(thickness: 0.6),
                              const Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ContainerProcess(
                                      mainTitle: "Blood Pressure",
                                      total: 900,
                                      data: Random().nextInt(800) + 100,
                                      color: Colors.red,
                                      backgroundColor:
                                          Colors.red.withOpacity(0.2),
                                      des: "141/90 mmhg",
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: ContainerProcess(
                                      mainTitle: "Body Temperature",
                                      total: 500,
                                      data: Random().nextInt(400) + 100,
                                      color: Colors.purple,
                                      backgroundColor:
                                          Colors.purple.withOpacity(0.2),
                                      des: "29'C",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: ContainerProcess(
                                      mainTitle: "Body Height",
                                      total: 1000,
                                      data: Random().nextInt(900) + 100,
                                      color: Colors.orange,
                                      backgroundColor:
                                          Colors.orange.withOpacity(0.2),
                                      des: "",
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: ContainerProcess(
                                      mainTitle: "Body Weight",
                                      total: 1000,
                                      data: Random().nextInt(900) + 100,
                                      color: Colors.blue,
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.2),
                                      des: "78Kg",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContainerProcess extends StatelessWidget {
  final String mainTitle;
  final int total;
  final int data;
  final Color color;
  final Color backgroundColor;
  final String des;
  const ContainerProcess({
    Key? key,
    required this.mainTitle,
    required this.total,
    required this.data,
    required this.color,
    required this.backgroundColor,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          Text(
            des,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          LinearPercentIndicator(
            lineHeight: 5,
            percent: data / total,
            progressColor: color,
            backgroundColor: Colors.white.withOpacity(0.2),
            animation: true,
            animationDuration: 1000,
            barRadius: const Radius.circular(20),
          ),
          const SizedBox(height: 10.0),
          Text(
              (data / total) > 0.8
                  ? 'Dangerous'
                  : ((data / total) > 0.4
                      ? "Normal"
                      : ((data / total) > 0.2 ? "Too low" : "Warning")),
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0)),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String mainTitle;
  final String title;
  const ProfileRow({
    Key? key,
    required this.mainTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
