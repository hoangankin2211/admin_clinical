import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:admin_clinical/features/overview/controller/overview_controller.dart';
import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants/global_widgets/chart/column_2_chart.dart';
import '../../../constants/global_widgets/chart/line_chart_design.dart';
import '../../../constants/global_widgets/color_title.dart';
import '../../../constants/global_widgets/rangeDate_picker_dialog.dart';
import '../../../services/data_service/medicine_service.dart';
import '../widgets/medical_today.dart';
import '../widgets/top_doctor.dart';

class Data {
  final String name;
  final double percents;
  final Color color;
  final String imagePath;
  Data(
      {required this.imagePath,
      required this.name,
      required this.percents,
      required this.color});
}

List<Map<String, dynamic>> listMedicine = [
  {
    "id": 1,
    "name": "Thuoc Dau dau",
    "1": 100,
    "2": 30,
    "amount": 100,
  },
  {
    "id": 2,
    "name": "Thuoc Dau bung",
    "1": 23,
    "2": 30,
    "amount": 300,
  },
  {
    "id": 3,
    "name": "Thuoc tieu chay",
    "1": 134,
    "2": 42,
    "amount": 200,
  },
  {
    "id": 4,
    "name": "Thuoc Dau chan",
    "1": 214,
    "2": 56,
    "amount": 400,
  }
];

List<Data> data = [
  Data(
      name: 'now',
      percents: (30.1 / 80.1 * 100).round().toDouble(),
      color: Colors.green,
      imagePath: 'assets/images/doctor1.png'),
  Data(
    name: '',
    percents: (20 / 80.1 * 100).round().toDouble(),
    color: AppColors.primaryColor,
    imagePath: 'assets/images/doctor2.png',
  ),
  Data(
    name: '',
    percents: (30 / 80.1 * 100).round().toDouble(),
    color: Colors.yellow,
    imagePath: 'assets/images/doctor3.png',
  ),
];

// ignore: must_be_immutable
class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});
  RxInt touchedIndex = (-1).obs;
  RxInt touchedIndex1 = (-1).obs;

  final overviewController = Get.find<OverviewController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 7,
            child: ListView(
              children: [
                const _headerField(),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Clinic Survey",
                      style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ...overviewController.listDataSurvey.map(
                        (e) => Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(e["icon"], size: 40.0, color: e["color"]),
                              const SizedBox(height: 10.0),
                              Text(
                                e["data"].toString(),
                                style: const TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                e["title"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                _graphField(context),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                _turnoverField(),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                _medicineField(),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.headline1TextColor.withOpacity(0.3),
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              overviewController.getUser().avt,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        overviewController.getUser().name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: AppColors.primarySecondColor),
                      ),
                      const SizedBox(height: 7.0),
                      const Text(
                        "Admin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Medical Today",
                            style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          Text(
                            "10 cl",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10.0),
                      MedicalTodayItem(
                          image: "assets/images/doctor1.png",
                          patientName: "Nguyen Minhh Hung",
                          doctorName: "Dr.Truong Huynh Duc Hoang",
                          time: DateTime.now(),
                          status: 0),
                      MedicalTodayItem(
                          image: "assets/images/doctor2.png",
                          patientName: "Nguyen Trung Hieu",
                          doctorName: "Dr.Truong Huynh  Hoang",
                          time: DateTime.now(),
                          status: 1),
                      MedicalTodayItem(
                          image: "assets/images/doctor3.png",
                          patientName: "Truong Huynh Duc Hoang",
                          doctorName: "Dr.Truong Huynh Duc ",
                          time: DateTime.now(),
                          status: 1),
                      MedicalTodayItem(
                          image: "assets/images/fake_avatar.jpg",
                          patientName: "Nguyen Minhh Hung",
                          doctorName: "Dr.Truong Huynh Duc Hoang",
                          time: DateTime.now(),
                          status: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Row _medicineField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Medicine Graph",
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () async {
                        await _showDatePicker(context: Get.context!);
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Week ",
                            style: TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down,
                              color: AppColors.primarySecondColor),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(
                      // color: Colors.red,
                      height: 210,
                      width: 210,
                      child: Obx(
                        () => PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex1.value = -1;
                                  return;
                                }
                                touchedIndex1.value = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              },
                            ),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 1,
                            centerSpaceRadius: 30,
                            sections: [
                              for (int i = 0;
                                  i <
                                      MedicineService
                                          .instance.listMedicine.length;
                                  i++)
                                Data(
                                    imagePath: 'assets/images/doctor2.png',
                                    name: MedicineService
                                        .instance.listMedicine[i].name,
                                    percents: (MedicineService.instance
                                                .listMedicine[i].amount /
                                            overviewController.sum.value *
                                            100)
                                        .round()
                                        .toDouble(),
                                    color: overviewController.listColor[i % 7]),
                            ]
                                .asMap()
                                .map<int, PieChartSectionData>((index, data) {
                                  final isTouched =
                                      index == touchedIndex1.value;
                                  return MapEntry(
                                    index,
                                    PieChartSectionData(
                                      color: data.color,
                                      value: data.percents,
                                      title: '${data.percents} %',
                                      radius: isTouched ? 80 : 70,
                                      titleStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.headline1TextColor,
                                      ),
                                      titlePositionPercentageOffset: 0.55,
                                      badgePositionPercentageOffset: .98,
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Obx(
                      () => SizedBox(
                        height: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...overviewController.getDataPieChartMedicine().map(
                                (e) =>
                                    ColorTitle(title: e.name, color: e.color))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(right: 15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Medicine",
                      style: TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Row(
                    //     children: const [
                    //       Text(
                    //         "Week ",
                    //         style: TextStyle(
                    //           color: AppColors.primarySecondColor,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16.0,
                    //         ),
                    //       ),
                    //       Icon(
                    //         Icons.arrow_drop_down,
                    //         color: AppColors.primarySecondColor,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const ListItem1(
                        checkHeader: true,
                        widgets: [
                          Text(
                            "ID",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            "Thuoc ton kho",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            "Thuoc ban duoc",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1),
                      Expanded(
                        child: Obx(() => ListView(
                              children: [
                                ...overviewController.listMedicine.map((e) =>
                                    ListItem1(
                                      checkHeader: true,
                                      widgets: [
                                        Text(
                                          e.id,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e.name,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e.amount.toString(),
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          e.listPass.length.toString(),
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.primarySecondColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                        Text(
                                          "\$${e.price}",
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _turnoverField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Turnover",
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () async {
                        await _showDatePicker(context: Get.context!);
                      },
                      child: Row(
                        children: const [
                          Text("Week ",
                              style: TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                          Icon(Icons.arrow_drop_down,
                              color: AppColors.primarySecondColor),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 210,
                    child: LineChartDesign(
                        maxTitle: overviewController.maxOfListInvoice.value
                            .toString(),
                        middleTitle:
                            (overviewController.maxOfListInvoice.value / 2)
                                .round()
                                .toString(),
                        listData: [
                          ...overviewController.data_invoice_chart.map(
                            (element) => FlSpot(
                              element['id'],
                              // ignore: unrelated_type_equality_checks
                              overviewController.maxOfListInvoice != 0
                                  ? (element['data'] /
                                          overviewController
                                              .maxOfListInvoice.value) *
                                      5
                                  : 0,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(right: 15.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Top Doctor",
                        style: TextStyle(
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Row(
                      //     children: const [
                      //       Text("LastWeek ",
                      //           style: TextStyle(
                      //               color: AppColors.primarySecondColor,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 16.0)),
                      //       Icon(
                      //         Icons.arrow_drop_down,
                      //         color: AppColors.primarySecondColor,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Obx(
                    () => SizedBox(
                      height: 210,
                      width: double.infinity,
                      child: ListView(
                        children: [
                          for (int i = 0;
                              i < overviewController.getLength.value;
                              i++)
                            TopDoctor2(
                                image: overviewController.listDoctor[i].avt!,
                                name: overviewController.listDoctor[i].name!,
                                price: 100.0),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  Row _graphField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.only(left: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Patients Medical Status',
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () async {
                        await _showDatePicker(context: Get.context!);
                      },
                      child: Row(
                        children: const [
                          Text("Week ",
                              style: TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                          Icon(Icons.arrow_drop_down,
                              color: AppColors.primarySecondColor),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // color: Colors.red,
                      height: 210,
                      width: 210,
                      child: Obx(
                        () => PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex.value = -1;
                                  return;
                                }
                                touchedIndex.value = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              },
                            ),
                            startDegreeOffset: 180,
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 1,
                            centerSpaceRadius: 30,
                            sections: data
                                .asMap()
                                .map<int, PieChartSectionData>((index, data) {
                                  final isTouched = index == touchedIndex.value;
                                  return MapEntry(
                                    index,
                                    PieChartSectionData(
                                      color: data.color,
                                      value: data.percents,
                                      title: '${data.percents} %',
                                      radius: isTouched ? 80 : 70,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      titlePositionPercentageOffset: 0.55,
                                      badgePositionPercentageOffset: .98,
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ColorTitle(color: Colors.yellow, title: "Cured"),
                        SizedBox(height: 5.0),
                        ColorTitle(
                            color: Colors.green, title: "Under Treatment"),
                        SizedBox(height: 5.0),
                        ColorTitle(
                            color: AppColors.primaryColor,
                            title: "Newly Reffered"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(right: 15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Number Of Patients',
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () => _showDatePickerPatient(context: context),
                      child: Row(
                        children: const [
                          Text("Last Week ",
                              style: TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0)),
                          Icon(Icons.arrow_drop_down,
                              color: AppColors.primarySecondColor),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 220,
                          child: ColumnChartTwoColumnCustom(
                            barGroups: [
                              ...overviewController.data_patient_chart.map(
                                (e) => makeGroupData(
                                    e['id'],
                                    overviewController.maxOfListPatient == 0
                                        ? 0
                                        : e['Male'] /
                                            overviewController
                                                .maxOfListPatient.value *
                                            20,
                                    0),
                              ),
                            ],
                            members: const [
                              'Sun',
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat'
                            ],
                            columnData:
                                overviewController.maxOfListPatient.value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 210,
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ColorTitle(
                              color: AppColors.primarySecondColor,
                              title: "Male"),
                          SizedBox(height: 5.0),
                          ColorTitle(
                              color: AppColors.primaryColor, title: "Female"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _showDatePicker({required BuildContext context}) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => DialogPickRangeDate(
        controller: overviewController.dateControllerTurnover,
        callback: () {
          overviewController.dateControllerTurnover.selectDateDoneClick();
          overviewController.fetchDataInvoiceChart();
          Get.back();
        },
      ),
    );
  }

  _showDatePickerPatient({required BuildContext context}) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => DialogPickRangeDate(
        controller: overviewController.dateControllerPatient,
        callback: () {
          overviewController.dateControllerPatient.selectDateDoneClick();
          overviewController.fetchDataPatientChart();
          Get.back();
        },
      ),
    );
  }
}

class _headerField extends StatelessWidget {
  const _headerField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.headline1TextColor.withOpacity(0.2),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.notifications_outlined,
                          color: AppColors.headline1TextColor,
                          size: 25.0,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.medical_information_outlined,
                          color: AppColors.headline1TextColor,
                          size: 25.0,
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.more_vert,
                          color: AppColors.headline1TextColor,
                          size: 25.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 220,
                margin: const EdgeInsets.only(right: 150),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.headline1TextColor.withOpacity(0.2),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 40.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '${DateFormat().add_yMMMEd().format(DateTime.now())} ${DateFormat().add_jms().format(DateTime.now())}',
                      style: const TextStyle(
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Image.asset(
                'assets/images/doctor1.png',
                height: 250,
                width: 250,
              ),
            )
          ],
        ),
      ),
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      toY: y1,
      color: AppColors.primaryColor,
      width: 7,
    ),
    BarChartRodData(
      toY: y2,
      color: AppColors.primarySecondColor,
      width: 7,
    ),
  ]);
}
