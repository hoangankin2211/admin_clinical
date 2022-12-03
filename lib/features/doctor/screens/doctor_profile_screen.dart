import 'package:admin_clinical/features/doctor/controller/doctor_detai_controller.dart';
import 'package:admin_clinical/features/doctor/widgets/doctor_card.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/comment_card.dart';
import '../../../models/doctor.dart';
import 'package:readmore/readmore.dart';

import '../widgets/dialog_view_all_comment.dart';
import '../widgets/information_item.dart';
import '../widgets/medical_exmamindation_item.dart';

List<Map<String, dynamic>> fakeData = [
  {
    "id": "113",
    "date": DateTime.now(),
    "cr": "Phong Kham noi 1",
    "pn": "Truong Huynh Duc Hoang",
    "status": 1,
  },
  {
    "id": "114",
    "date": DateTime.now(),
    "cr": "Phong Kham noi 2",
    "pn": "Nguyen Minh Hung",
    "status": 1,
  },
  {
    "id": "115",
    "date": DateTime.now(),
    "cr": "Phong Kham noi 3",
    "pn": "Nguyen Trung Hieu",
    "status": 2,
  },
  {
    "id": "116",
    "date": DateTime.now(),
    "cr": "Phong Kham noi 4",
    "pn": "Phan Thien Nhan",
    "status": 1,
  },
];

class DoctorProfileScreen extends StatelessWidget {
  DoctorProfileScreen({super.key});
  final controller = Get.find<DoctorDetailController>();
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listInfo = [
      {
        'image': 'assets/icons/people.svg',
        'title': 'patients',
        'data': '5.000+'
      },
      {
        'image': 'assets/icons/experiences.svg',
        'title': 'year experiences',
        'data': controller.doctor.experience.toString(),
      },
      {'image': 'assets/icons/star.svg', 'title': 'rating', 'data': '4.8'},
      {'image': 'assets/icons/chat.svg', 'title': 'reviews', 'data': '4.942'},
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _mainProfileField(listInfo, context),
                    const SizedBox(height: 20.0),
                    Container(
                      height: double.infinity,
                      width: 0.1,
                      color: Colors.black,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Medical examination inforamation',
                                        style: TextStyle(
                                            color: AppColors.headline1TextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: _patientInformationFiled()),
                                        const SizedBox(width: 10.0),
                                        Container(
                                            width: 0.2,
                                            height: double.infinity,
                                            color: Colors.grey),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          flex: 6,
                                          child: _examinationInformationField(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey, thickness: 0.3),
                          Expanded(
                            flex: 5,
                            child: _medicalExmainationField(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Column _medicalExmainationField() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Medical examination schedule',
            style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Date Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Clinic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Patient\'s name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...fakeData.map(
                (e) => MedicalExaminationItem(
                  id: e["id"],
                  date: e["date"],
                  clinicRoom: e["cr"],
                  patientName: e["pn"],
                  status: e["status"],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _patientInformationFiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              InformationItem(
                mainTitle: "Type",
                title: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.backgroundColor,
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Kham va tu van, ke don',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Patient",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Row(
                    children: const [
                      Text(
                        'Nguyen Minh Hung',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Phone",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Row(
                    children: const [
                      Text(
                        '0935703991',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Date Born",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Text(
                    DateFormat().add_yMd().format(DateTime.now()),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Gender",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "Male",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Address",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "Thi Xa An Khe, Tinh Gia lai",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _examinationInformationField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Clinic room",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "Phong Kham noi so 1",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Temprat",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "30*C",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Height",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "170cm",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Weight",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "70Kg",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Huyet ap",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "100mmHg",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Ngay Lap",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Text(
                    DateFormat().add_yMd().format(DateTime.now()),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Doctor",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "Dr Nguyen Minh Hung",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InformationItem(
                mainTitle: "Description",
                title: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.backgroundColor,
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: const Text(
                    "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                    maxLines: 3,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ]),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.blue),
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
                      "Result",
                      style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InformationItem(
                      mainTitle: "Status",
                      title: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.green.withOpacity(0.3),
                            ),
                            child: const Text(
                              'Completed',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const InformationItem(
                      mainTitle: "Price",
                      title: Text(
                        '\$20.0',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    InformationItem(
                      mainTitle: "Check Out",
                      title: Text(
                        DateFormat().add_yMd().format(DateTime.now()),
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _mainProfileField(
      List<Map<String, dynamic>> listInfo, BuildContext context) {
    return Expanded(
      flex: 2, //
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.headline1TextColor.withOpacity(0.3),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            DoctorCard1(
                doctor: Doctor(
              email: "hungnguyen.201102ak@gmail.com",
              name: controller.doctor.name,
              dateBorn: controller.doctor.dateBorn,
              avt: controller.doctor.avt,
              timeStart: 20,
              timeFinish: 200,
              type: controller
                  .getDepartMent(controller.doctor.departMent!,
                      DataService.instance.listDepartMent.value)
                  .name,
              description: controller.doctor.description,
              experience: controller.doctor.experience,
              address: controller.doctor.address,
              gender: "Male",
            )),
            const SizedBox(height: 10),
            const Divider(thickness: 0.2, color: Colors.grey),
            const SizedBox(height: 10),
            Row(
              children: [
                // Expanded(child: child)
                for (var item in listInfo)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.2),
                            ),
                            child: SvgPicture.asset(item['image'],
                                color: AppColors.primaryColor, height: 30),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['data'],
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['title'],
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About me',
                  style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ReadMoreText(
                controller.doctor.description!,
                trimLines: 5,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Working Time',
                  style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Monday - Friday, ${08}:00 AM - ${20}:00 PM',
                  style: TextStyle(
                      color: AppColors.headline1TextColor, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 0.3, color: Colors.grey),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  InkWell(
                    onTap: () async => await showDialog(
                        builder: (context) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: DialogViewAllComment(),
                            ),
                        context: context),
                    child: const Text(
                      'See more',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              children: const [
                CommentCard(
                  name: 'Charolette Hanlin',
                  image: 'assets/images/google.png',
                  favCount: 629,
                  title:
                      'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                  day: 6,
                  star: 4,
                  checkLike: true,
                  check: 1,
                ),
                CommentCard(
                  name: 'Nguyen Minh Hung',
                  image: 'assets/images/fake_avatar.jpg',
                  favCount: 300,
                  title: 'Doctors who are very skilled and fast in service',
                  day: 8,
                  star: 3,
                  checkLike: true,
                  check: 1,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
