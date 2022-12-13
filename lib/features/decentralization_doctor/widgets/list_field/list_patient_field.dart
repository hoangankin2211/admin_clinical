import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../list_patient_item.dart';
import '../row_consulation_item.dart';

class ListPatientField extends StatelessWidget {
  const ListPatientField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          fontSize: 20.0,
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
                      fontSize: 20.0,
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
                      child: ListView(
                        // crossAxisAlignments: CrossAxisAlignment.start,
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
}
