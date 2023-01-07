import 'package:admin_clinical/constants/global_widgets/chart/line_chart_design.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/report/controller/report_controller.dart';
import 'package:admin_clinical/models/invoice.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../widgets/dialog_pick_year.dart';
import '../widgets/invoice_report_item.dart';
import '../widgets/patient_in_month_row.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final controller = Get.find<ReportController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Report',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: CustomButton(
                      title: "Select Year",
                      onPressed: () => Get.dialog(
                        DialogPickYear(
                          callback: (value) {
                            controller.selectDate['year'] = value;
                            controller.fetchAllChartData(
                                controller.selectTypeOfChart.value);
                          },
                        ),
                      ),
                    ),
                  ),
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
                          _chartField(),
                          _invoiceField(),
                        ],
                      ),
                    ),
                    _listPatientField(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded _listPatientField() {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'List Patient',
              style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 1),
            const SizedBox(height: 10.0),
            Obx(
              () => Expanded(
                child: ListView(
                  children: [
                    for (var item in controller.listHealthRecoord.values)
                      if (controller.selectDate['year'] == item.dateCreate.year)
                        PatientInMonthRow(
                          name:
                              controller.listPatient.containsKey(item.patientId)
                                  ? controller.listPatient[item.patientId]!.name
                                  : 'Is Removed',
                          time:
                              DateFormat().add_yMMMEd().format(item.dateCreate),
                          groupValue: 0,
                          func: (value) {},
                          press: () {},
                          thumb:
                              controller.listPatient.containsKey(item.patientId)
                                  ? controller.listPatient[item.patientId]!.avt
                                  : '',
                        )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded _invoiceField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'List Invoice',
                style: TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                  child: Obx(
                () => ListView(
                    children: controller.listInvoice
                        .map(
                          (element) => (element.createTime.year ==
                                  controller.selectDate['year'])
                              ? InvoiceReportItem(element: element)
                              : const SizedBox(),
                        )
                        .toList()),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _chartField() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(width: 1, color: AppColors.primaryColor),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: CustomButton(
                    title: "Swap",
                    onPressed: () {
                      controller.selectTypeOfChart.value =
                          1 - controller.selectTypeOfChart.value;
                      controller.selectMonth.value =
                          (controller.selectTypeOfChart.value == 0) ? 1 : 0;
                      controller.fetchAllChartData(
                          controller.selectTypeOfChart.value);
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Obx(
                  () => controller.selectTypeOfChart.value == 0
                      ? Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (controller.selectMonth.value > 1) {
                                  controller.selectMonth.value--;
                                } else {
                                  controller.selectMonth.value = 12;
                                }
                                controller.fetchAllChartData(0);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              controller.selectMonth.value.toString(),
                              style: const TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            InkWell(
                              onTap: () {
                                if (controller.selectMonth.value < 12) {
                                  controller.selectMonth.value++;
                                } else {
                                  controller.selectMonth.value = 1;
                                }
                                controller.fetchAllChartData(0);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Obx(
                  () => LineChartDesign1(
                    maxTitle: (controller.maxOfListInvoice.value).toString(),
                    middleTitle:
                        (controller.maxOfListInvoice.value / 2).toString(),
                    listData: [
                      ...controller.chartData.map(
                        (element) => FlSpot(
                          element['id'],
                          // ignore: unrelated_type_equality_checks
                          controller.maxOfListInvoice != 0
                              ? (element['data'] /
                                      controller.maxOfListInvoice.value) *
                                  5
                              : 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
