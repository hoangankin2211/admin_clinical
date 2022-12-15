import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/patient/widgets/health_record_detail.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/global_widgets/comment_card.dart';
import '../../../models/health_record.dart';
import '../../../models/patient.dart';
import '../../invoice/screens/verify_invoice_information_screen.dart';
import '../widgets/edit_patient_dialog.dart';

// ignore: must_be_immutable
class PatientDetailScreen extends StatelessWidget {
  PatientDetailScreen({super.key, required this.patient});

  var amount = 0.0.obs;
  final Patient patient;
  late final List<String> healthRecord = patient.healthRecord ?? [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Patient List ',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.grey),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          ' ${patient.name} ',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _profileFiled(context),
                              _listMedicalField(),
                            ],
                          ),
                        ),
                        _reviewField(constraints, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Expanded _reviewField(BoxConstraints constraints, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.backgroundColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Satisfation Rate: ',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 20.0),
                      Text(
                        ' 4.8',
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'All Reviews',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10.0),
                        ],
                      ),
                      child: ListView(children: const [
                        CommentCard(
                          name: 'Charolette Hanlin',
                          image: 'assets/images/doctor2.png',
                          favCount: 629,
                          title:
                              'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                          day: 6,
                          star: 4,
                          checkLike: true,
                          check: 1,
                        ),
                        Divider(thickness: 1),
                        CommentCard(
                          name: 'Charolette Hanlin',
                          image: 'assets/images/doctor2.png',
                          favCount: 629,
                          title:
                              'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                          day: 6,
                          star: 4,
                          checkLike: true,
                          check: 1,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Obx(() => InvoiceAmountFormWidget(amount: amount.value)),
          ),
        ],
      ),
    );
  }

  Expanded _listMedicalField() => Expanded(
        flex: 6,
        child: Container(
          margin: const EdgeInsets.only(
              top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.backgroundColor,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10.0)
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[100],
                    ),
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Text(
                        'Treatment History',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: [
                            const Text(
                              'List Treatment',
                              style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.keyboard_arrow_up_rounded,
                                        color: Colors.grey),
                                    Text(
                                      'Change Year',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                      Expanded(
                        child: ListView(
                          children: healthRecord.map((e) {
                            HealthRecord? temp =
                                HealthRecordService.listHealthRecord[e];
                            if (temp != null) {
                              return Material(
                                type: MaterialType.card,
                                child: InkWell(
                                  onTap: () async {
                                    double result = 0;
                                    if (temp.medicines != null) {
                                      for (var element in temp.medicines!) {
                                        result += element['amount'] ?? 0.0;
                                      }
                                    }
                                    if (temp.services != null) {
                                      for (var element in temp.services!) {
                                        result += element['amount'] ?? 0.0;
                                      }
                                    }
                                    amount.value = result;
                                  },
                                  child: MedicalItem(
                                    healthRecord: temp,
                                    onPressedDetailButton: () async {
                                      await Get.dialog(
                                        Dialog(
                                          child: SizedBox(
                                            height: Get.height * 0.9,
                                            width: Get.width * 0.8,
                                            child: HealthRecordDetail(
                                              patient: patient,
                                              healthRecord: temp,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Expanded _profileFiled(BuildContext context) => Expanded(
        flex: 5,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10.0)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage:
                          (patient.avt != null && patient.avt!.isNotEmpty)
                              ? NetworkImage(
                                  patient.avt!,
                                ) as ImageProvider
                              : const AssetImage('images/user.png'),
                      radius: 70,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      ' ${patient.name} ',
                      style: const TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      patient.email ?? 'hungnguyen.201102ak@gmail.com',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('100',
                                  style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              SizedBox(height: 5.0),
                              Text(
                                'Medical',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 60, width: 0.5, color: Colors.grey),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('100',
                                  style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              SizedBox(height: 5.0),
                              Text(
                                'Upcoming',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: CustomButton(
                          text: "Edit Profile",
                          onTap: () {
                            Get.dialog(
                              EditPatientDialog(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.width * 0.6,
                                patient: patient,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10.0, left: 5.0, right: 10.0, bottom: 5.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10.0)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        ProfileItem(
                          header: "Gender",
                          title: patient.gender,
                        ),
                        ProfileItem(
                          header: "Birthday",
                          title: patient.dob,
                        ),
                        ProfileItem(
                          header: "Phone Number",
                          title: patient.dob,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(thickness: 0.5),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        ProfileItem(
                          header: "Street Address",
                          title: patient.address,
                        ),
                        const ProfileItem(
                          header: "City",
                          title: 'Ho Chi Minh City',
                        ),
                        const ProfileItem(
                          header: "Zip Code",
                          title: '655849',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(thickness: 0.5),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        ProfileItem(
                          header: "Member Status",
                          title: patient.status,
                        ),
                        ProfileItem(
                          header: "Registered Date",
                          title: DateFormat().add_yMMMEd().format(
                                (healthRecord.isNotEmpty)
                                    ? (HealthRecordService
                                        .listHealthRecord[healthRecord.first]!
                                        .dateCreate)
                                    : DateTime.now(),
                              ),
                        ),
                        const Expanded(child: SizedBox())
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}

class MedicalItem extends StatelessWidget {
  const MedicalItem({
    Key? key,
    required this.healthRecord,
    required this.onPressedDetailButton,
  }) : super(key: key);
  final HealthRecord healthRecord;
  final Function() onPressedDetailButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: AppColors.primaryColor),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(top: 10.0, bottom: 10, right: 20.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat()
                              .add_yMMMEd()
                              .format(healthRecord.dateCreate),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '${DateFormat().add_jm().format(
                                healthRecord.dateCreate
                                    .subtract(const Duration(hours: 2)),
                              )} - ${DateFormat().add_jm().format(healthRecord.dateCreate)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 60, width: 0.5, color: Colors.grey),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Department',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'healthRecord.departmentId',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Container(height: 60, width: 0.5, color: Colors.grey),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Doctor',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              DataService.instance
                                      .getNameDoctor(healthRecord.doctorId) ??
                                  "Nguyen Minh Hung",
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: onPressedDetailButton,
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                  color: Colors.blueGrey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.blue[100],
                              ),
                              child: Text(
                                '\$${healthRecord.totalMoney}',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
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
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String header;
  final String title;
  const ProfileItem({
    Key? key,
    required this.header,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          header,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ]),
    );
  }
}
