import 'package:admin_clinical/constants/fake_data.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/chart/column_2_chart.dart';
import '../../../constants/global_widgets/chart/line_chart_design.dart';

class MedicineScreen extends StatelessWidget {
  MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _overviewMedicineView(),
                      const SizedBox(height: 10.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10.0),
                      _listMedicineView(),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                _rightField(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded _rightField() {
    return Expanded(
      flex: 3,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Medicine View",
                      style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(children: const [
                        Text("Last Week ",
                            style: TextStyle(
                                color: AppColors.primarySecondColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                        Icon(Icons.arrow_drop_down,
                            color: AppColors.primarySecondColor),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 210,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.2),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: const LineChartDesign(listData: [
                    FlSpot(0, 3.44),
                    FlSpot(1, 2.44),
                    FlSpot(2, 4.44),
                    FlSpot(3, 1.44),
                    FlSpot(4, 5),
                    FlSpot(5, 4.44),
                    FlSpot(6, 2.44),
                  ]),
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.headline1TextColor
                                    .withOpacity(0.2),
                                blurRadius: 10.0),
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/doctor2.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Shakira lala",
                            style: TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Thuoc Dau Bung",
                            style: TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Price: \$500.0",
                            style: TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.withOpacity(0.7),
                        ),
                        child: Row(children: const [
                          Icon(Icons.camera, color: Colors.white),
                          Text(
                            " Edit Thumbnails",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                const InputWithHeaderText(
                  header: "Medicine Name",
                  hint: "Enter Medicine Name",
                ),
                const SizedBox(height: 10.0),
                const InputWithHeaderText(
                  header: "Medicine Price",
                  hint: "Enter Medicine Price",
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select type of Medecine",
                      style: const TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Thuoc Dau bung",
                              style: const TextStyle(
                                color: AppColors.primarySecondColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_drop_down,
                                color: AppColors.primarySecondColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const InputWithHeaderText(
                  header: "Description",
                  hint: "Enter description",
                  maxLines: 4,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    title: "Edit Medicine",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _listMedicineView() {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Medicines",
            style: TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20),
          _headerListMedcine(),
          const SizedBox(height: 10),
          Expanded(
              child: ListView(
            children: [
              ...FakeData.fakeDataMedicine.map(
                (e) => ListItem(
                  checkShadow: true,
                  widgets: [
                    Row(children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.headline1TextColor.withOpacity(0.3),
                              blurRadius: 5.0,
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              e["image"],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          " ${e["name"]}",
                          style: const TextStyle(
                            color: AppColors.primarySecondColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      )
                    ]),
                    Text(
                      e["type"],
                      style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      e["rm"].toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      e["s"].toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '\$${e["price"]}',
                      style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red.withOpacity(0.6),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.delete, color: Colors.white),
                                  Text(
                                    " Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue.withOpacity(0.6),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.edit, color: Colors.white),
                                  Text(
                                    " Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
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
              )
            ],
          ))
        ],
      ),
    );
  }

  ListItem1 _headerListMedcine() {
    return ListItem1(
      widgets: [
        Row(
          children: const [
            Text(
              "Name ",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          ],
        ),
        Row(
          children: const [
            Text(
              "Type Medicine ",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          ],
        ),
        const Text(
          "Remaining ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "Sold ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "Price ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Expanded _overviewMedicineView() {
    return Expanded(
      flex: 3,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Overview",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(children: const [
                Text("Last Week ",
                    style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Icon(Icons.arrow_drop_down,
                    color: AppColors.primarySecondColor),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _numberDrugField(), //
                    const SizedBox(height: 10.0),
                    _remainingMedcineField(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: ColumnChartTwoColumnCustom(
                    barGroups: [
                      makeGroupData(0, 150 / 300 * 20, 60 / 300 * 20),
                      makeGroupData(1, 180 / 300 * 20, 70 / 300 * 20),
                      makeGroupData(2, 80 / 300 * 20, 50 / 300 * 20),
                      makeGroupData(2, 100 / 300 * 20, 30 / 300 * 20),
                      makeGroupData(1, 180 / 300 * 20, 70 / 300 * 20),
                      makeGroupData(2, 80 / 300 * 20, 50 / 300 * 20),
                      makeGroupData(2, 100 / 300 * 20, 30 / 300 * 20),
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
                    columnData: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Expanded _remainingMedcineField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(FontAwesome.medkit, color: Colors.red),
                Expanded(
                  child: Text(
                    " Remaining medicine",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Amount: ",
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                        ),
                      ),
                      TextSpan(
                        text: "233 ",
                        style: TextStyle(
                          color: AppColors.primarySecondColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Price: ",
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                        ),
                      ),
                      TextSpan(
                        text: "\$300 ",
                        style: TextStyle(
                          color: AppColors.primarySecondColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _numberDrugField() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(FontAwesome.medkit, color: Colors.green),
                Expanded(
                  child: Text(
                    " Number of drugs sold",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Amount: ",
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                        ),
                      ),
                      TextSpan(
                        text: "233 ",
                        style: TextStyle(
                          color: AppColors.primarySecondColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Price: ",
                        style: TextStyle(
                          color: AppColors.headline1TextColor,
                        ),
                      ),
                      TextSpan(
                        text: "\$300 ",
                        style: TextStyle(
                          color: AppColors.primarySecondColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputWithHeaderText extends StatelessWidget {
  final String header;
  final String hint;
  final int? maxLines;
  const InputWithHeaderText({
    Key? key,
    required this.header,
    required this.hint,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 5.0),
        CustomTextFormField(
          hint: hint,
          maxLine: maxLines ?? 1,
        ),
      ],
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      toY: y1,
      color: Colors.green,
      width: 7,
    ),
    BarChartRodData(
      toY: y2,
      color: Colors.red,
      width: 7,
    ),
  ]);
}
