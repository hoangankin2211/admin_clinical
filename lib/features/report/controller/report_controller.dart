import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
// import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../models/invoice.dart';

class ReportController extends GetxController {
  RxMap<String, Patient> listPatient = RxMap<String, Patient>({});
  RxMap<String, HealthRecord> listHealthRecoord =
      RxMap<String, HealthRecord>({});
  RxList<Invoice> listInvoice = RxList<Invoice>([]);
  RxMap<String, dynamic> selectDate = {
    'month': DateTime.now().month,
    'year': DateTime.now().year,
  }.obs;
  RxList<Map<String, dynamic>> chartData = RxList<Map<String, dynamic>>([]);
  RxInt maxOfListInvoice = 0.obs;

  RxInt selectTypeOfChart = 0.obs;
  RxInt selectMonth = 1.obs;

  fetchAllChartData(int type) {
    chartData.clear();
    DateTime x1 = DateTime(2019, 1, 0).toUtc();
    int lengthDate = DateTime(2019, 2, 0).toUtc().difference(x1).inDays;
    chartData.value = (type == 0)
        ? [
            for (int i = 1; i <= lengthDate; i++)
              {
                'id': i,
                'data': 0,
              }
          ]
        : [
            for (int i = 1; i <= 12; i++)
              {
                'id': i,
                'data': 0,
              }
          ];
    for (var item in InvoiceService.instance.listInvoice) {
      if (item.createTime.year == selectDate['year']) {
        if (selectMonth.value != 0 && type == 0) {
          chartData[item.createTime.day - 1]['data'] +=
              (item.createTime.month == selectMonth.value) ? item.amount : 0;
        } else {
          int index =
              (type == 0) ? item.createTime.day - 1 : item.createTime.month - 1;
          chartData[index]['data'] += item.amount;
        }
      }
    }
    maxOfListInvoice.value = [for (var item in chartData) item['data']]
        .reduce((v, e) => v > e ? v : e);
  }

  @override
  void onInit() {
    super.onInit();
    listPatient = PatientService.listPatients;
    listInvoice = InvoiceService.instance.listInvoice;
    listHealthRecoord = HealthRecordService.listHealthRecord;
    fetchAllChartData(0);
    update();
  }

  //view all doctor page

}
