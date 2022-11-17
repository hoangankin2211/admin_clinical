import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/fake_data.dart';
import '../../../constants/global_widgets/header_list_item.dart';
import '../../../constants/global_widgets/list_item.dart';
import '../widgets/top_doctor_card.dart';

class DoctorOverView extends StatelessWidget {
  final VoidCallback tapNextPage;
  const DoctorOverView({
    Key? key,
    required this.tapNextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.person,
                        color: AppColors.primaryColor, size: 30.0),
                    Text(
                      " Top Doctor",
                      style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      TopDoctorCard(
                        name: "HEAD OF THE DEPARTMENT",
                        image: "assets/images/doctor1.png",
                        description:
                            "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                        type: "Dentist",
                        ratings: 4.8,
                      ),
                      TopDoctorCard(
                        name: "HEAD OF THE DEPARTMENT",
                        image: "assets/images/doctor3.png",
                        description:
                            "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                        type: "Dentist",
                        ratings: 4.8,
                      ),
                      TopDoctorCard(
                        name: "HEAD OF THE DEPARTMENT",
                        image: "assets/images/doctor2.png",
                        description:
                            "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                        type: "Dentist",
                        ratings: 4.8,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Overview",
                    style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10.0),
                  Expanded(flex: 4, child: _allDoctoField()),
                  const SizedBox(height: 10.0),
                  Expanded(flex: 4, child: _allMedicalDepartMentField()),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: tapNextPage,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AppColors.primaryColor.withOpacity(0.7),
                            ),
                            child: const Text(
                              "Go to thao tac all",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Column _allMedicalDepartMentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "All Medical Department",
          style: TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        const SizedBox(height: 10.0),
        const HeaderListItem(
          checkHeader: true,
          titles: ["ID", "Name", "Rating", "Counting"],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...FakeData.fakeMedicalDepartment.map(
                  (e) => Column(
                    children: [
                      ListItem(
                        checkHeader: true,
                        widgets: [
                          Text(
                            '${e["id"]}',
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            '${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Row(
                            children: [
                              (e["ratings"] > 0)
                                  ? const Icon(Icons.trending_up_outlined,
                                      color: Colors.green)
                                  : const Icon(Icons.trending_down_outlined,
                                      color: Colors.red),
                              Expanded(
                                child: Text(
                                  '${(e["ratings"]).abs()} %',
                                  style: const TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${e["count"]}',
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _allDoctoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "All Doctor",
          style: TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        const SizedBox(height: 10.0),
        const HeaderListItem(
          checkHeader: true,
          titles: [
            "ID",
            "Name",
            "Rating",
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...FakeData.fakeDataDoctor.map(
                  (e) => Column(
                    children: [
                      ListItem(
                        checkHeader: true,
                        widgets: [
                          Text(
                            '${e["index"]}',
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            '${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellowAccent),
                              Text(
                                '${e["ratings"]} rating',
                                style: const TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
