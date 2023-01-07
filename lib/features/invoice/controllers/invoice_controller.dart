import 'package:admin_clinical/features/invoice/screens/make_invoice_screen.dart';
import 'package:admin_clinical/features/turnover/screen/turnover_main_screen.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';
import '../../../models/health_record.dart';
import '../../../models/invoice.dart';

class InvoiceController extends GetxController {
  // Rx<Patient?> selectedPatient = Rx(null);
  Rx<HealthRecord?> selectedHealthRecord = Rx(null);
  Rx<Invoice?> selectedInvoice = Rx(null);
  RxList<String> lInvoiceSelect = <String>[].obs;
  var selectedPage = 0.obs;
  RxList<Invoice> listInvoice = <Invoice>[].obs;
  List<String> listStatus = ["Cancelled", "Overdue", "Paid"];
  RxInt selectStatus = 0.obs;
  RxList<Invoice> listInvoiceSearchBy = <Invoice>[].obs;
  // RxDouble cancelled_invoice_amount = 0.0.obs;
  RxMap<String, dynamic> cancelled_invoice_amount = RxMap({
    'data': 0.0,
    'count': 0,
  });
  RxMap<String, dynamic> all_invoice_amount = RxMap({
    'data': 0.0,
    'count': 0,
  });
  RxMap<String, dynamic> paid_invoice_amount = RxMap({
    'data': 0.0,
    'count': 0,
  });
  late final PageController pageController =
      PageController(initialPage: selectedPage.value, keepPage: true);
  late final List<Widget> pages = [
    TurnoverMainScreen(),
    MakeInvoiceScreen(),
    Obx(() => verifiedPage.value)
  ];

  Rx<Widget> verifiedPage = Rx<Widget>(const SizedBox());

  void changePage(int value) {
    if (value >= 0 && value < pages.length) {
      selectedPage.value = value;
    }
    pageController.animateToPage(
      selectedPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  RxList<Map<String, dynamic>> name = [
    {
      "name": "Medicine",
      "check": false.obs,
    },
    {
      "name": "Payment",
      "check": false.obs,
    },
  ].obs;
  RxList<Map<String, dynamic>> status = [
    {
      "name": "All Invoices",
      "check": false.obs,
      "i": 4,
    },
    {
      "name": "Paid",
      "check": false.obs,
      "i": 2,
    },
    {
      "name": "Overdude",
      "check": false.obs,
      "i": 1,
    },
    {
      "name": "Cancelled",
      "check": false.obs,
      "i": 0,
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    listInvoice = InvoiceService.instance.listInvoice;
    initAllData();
  }

  fetchDataByCategory() {
    listInvoiceSearchBy.clear();
    for (var item in listInvoice) {
      if (name[name.indexWhere((element) => element['name'] == item.category)]
              ['check']
          .value) {
        listInvoiceSearchBy.add((item));
      }
    }
  }

  void deleteInvoice(String id) async {
    bool delete =
        await InvoiceService.instance.deleteInvoice(Get.context!, id: id);
    if (delete) {
      InvoiceService.instance.listInvoice
          .removeWhere((element) => element.id == id);
      Get.dialog(
        const SuccessDialog(question: "Delete Invoice", title1: "Success"),
      );
    }
  }

  void deleteManyInvoice() async {
    bool delete = await InvoiceService.instance
        .deleteManyInvoice(Get.context!, listId: lInvoiceSelect);
    if (delete) {
      InvoiceService.instance.listInvoice
          .removeWhere((element) => lInvoiceSelect.contains(element.id));
      Get.back();
      Get.dialog(
        const SuccessDialog(question: "Delete Invoice", title1: "Success"),
      );
    }
  }

  fetchDataByStatus() {
    listInvoiceSearchBy.clear();
    for (var item in listInvoice) {
      if (status[status.indexWhere((element) => element['i'] == item.status)]
              ['check']
          .value) {
        listInvoiceSearchBy.add(item);
      }
    }
  }

  void initAllData() {
    for (var item in listInvoice) {
      all_invoice_amount.value['data'] += item.amount;
      all_invoice_amount.value['count'] += 1;
      cancelled_invoice_amount.value['count'] += 1;
      if (item.status == 0) {
        cancelled_invoice_amount.value['data'] += item.amount;
        paid_invoice_amount.value['count'] += 1;
      } else if (item.status == 2) {
        paid_invoice_amount.value['data'] += item.amount;
      } else {}
    }
  }

  RxList<Invoice> get getListInvoice =>
      listInvoiceSearchBy.isEmpty ? listInvoice : listInvoiceSearchBy;

  RxBool loadingChangeStatus = false.obs;
  changeStatusInvoice(BuildContext context, String id) async {
    loadingChangeStatus.value = true;
    Invoice? temp = await InvoiceService.instance
        .changeStatusinvoice(context, id: id, status: selectStatus.value);
    if (temp != null) {
      int index = InvoiceService.instance.listInvoice
          .indexWhere((element) => element.id == id);
      InvoiceService.instance.listInvoice[index] = temp;
      listInvoice[index] = temp;
      loadingChangeStatus.value = false;
      Get.back();
      Get.dialog(
        const SuccessDialog(
            question: "Change Status Invoice", title1: "Success"),
      );
      return true;
    }
    return false;
  }

  List<Map<String, dynamic>> listInvoices = [
    {
      "status": 0,
      "icon": Icons.file_copy_outlined,
      "title": "All Invoices",
      "data1": 50,
    },
    {
      "status": 1,
      "icon": Icons.folder_copy_outlined,
      "title": "Paid Invoices",
      "data1": 60,
    },
    {
      "status": 2,
      "icon": Icons.paid_outlined,
      "title": "All Invoices",
      "data1": 70,
    },
    {
      "status": 3,
      "icon": Icons.security_outlined,
      "title": "Cancelled Invoices",
      "data1": 80,
    },
  ];
}
