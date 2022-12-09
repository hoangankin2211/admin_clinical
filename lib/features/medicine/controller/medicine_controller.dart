import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/overview/controller/overview_controller.dart';
import 'package:admin_clinical/models/invoice.dart';
import 'package:admin_clinical/models/medicine.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  final controller = Get.find<OverviewController>();
  RxList<Medicine> listMedicine = <Medicine>[].obs;
  RxList<String> listType = <String>[].obs;
  List<String> listUnit = [
    'Pill',
    'Pack',
    'Tablet',
    'potion',
  ];
  // TextEdittingController
  RxBool isLoadingInsert = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  RxInt selectType = 0.obs;
  RxInt selectUnit = 0.obs;
  RxInt price = 0.obs;
  RxInt cost = 0.obs;
  RxInt amount = 0.obs;

  RxInt selectMedcine = 0.obs;

  void fetchAllListType() {
    nullAllField();
    listType.value.clear();
    for (var item in listMedicine) {
      if (!(listType.value.contains(item.type))) {
        listType.value.add(item.type);
      }
    }
  }

  // TextEditintCOntroller for edit medcine
  Rx<TextEditingController> rxnameController = TextEditingController().obs;
  Rx<TextEditingController> rxdescriptionController =
      TextEditingController().obs;
  RxInt selectTypeEdit = 0.obs;
  RxBool isLoadingEdit = false.obs;
  Rx<TextEditingController> rxpriceController = TextEditingController().obs;
  funcselectMedincine(int index) {
    selectMedcine.value = index;
    rxnameController.value.text = listMedicine[selectMedcine.value].name;
    rxdescriptionController.value.text =
        listMedicine[selectMedcine.value].description;
    rxpriceController.value.text =
        listMedicine[selectMedcine.value].price.toString();
    for (int i = 0; i < listType.value.length; i++) {
      if (listType.value[i] == listMedicine[selectMedcine.value].type) {
        selectTypeEdit.value = i;
        break;
      }
    }
  }

  void nullAllField() {
    nameController.clear();
    descriptionController.clear();
    typeController.clear();
    selectType.value = 0;
    selectUnit.value = 0;
    price.value = 0;
    cost.value = 0;
    amount.value = 0;
  }

  updateAmountMedicine(
    BuildContext context,
    int index,
  ) async {
    if (amount.value > 0) {
      Medicine? temp = await MedicineService.instance.updateAMountMedicine(
          context,
          id: listMedicine.value[index].id,
          amount: amount.value);
      if (temp != null) {
        MedicineService.instance.listMedicine.value[index] = temp;
        // ignore: use_build_context_synchronously
        Invoice? temp1 = await InvoiceService.instance.addInvoiceMedicine(
            context,
            thumb: temp.thumbnails,
            amount: amount.value * temp.cost,
            status: 0,
            title: "Imported Medicines",
            medicineId: temp.id,
            category: "Medicine");
        if (temp1 != null) {
          InvoiceService.instance.listInvoice.add(temp1);
        }
        listMedicine.value[index] = temp;
        controller.fetchDataInvoiceChart();
        Get.back();
        Get.dialog(
          const SuccessDialog(
              question: "Update amount Medicine", title1: "Success"),
        );
      }
    }
  }

  insertNewMedicine(BuildContext context, Uint8List? image) async {
    if (nameController.text == "" ||
        descriptionController.text == "" ||
        typeController.text == "" ||
        price.value == 0 ||
        cost.value == 0 ||
        amount.value == 0) {
      Get.dialog(const ErrorDialog(
          question: 'Insert new Medicine', title1: "Field is Null"));
    } else {
      isLoadingInsert.value = true;
      String? imageUrl =
          'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=';
      if (image != null) {
        imageUrl = (await convertUti8ListToUrl(image, nameController.text)) ??
            'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=';
      }
      // ignore: use_build_context_synchronously
      Medicine? temp = await MedicineService.instance.insertNewMedcine(
        context,
        name: nameController.text,
        thumbnails: imageUrl,
        price: price.value.toDouble(),
        cost: cost.value.toDouble(),
        type: typeController.text,
        description: descriptionController.text,
        unit: listUnit[selectUnit.value],
        amount: amount.value,
      );
      if (temp != null) {
        MedicineService.instance.listMedicine.add(temp);
        isLoadingInsert.value = false;
        Get.back();
        Get.dialog(
          const SuccessDialog(
              question: "Insert new Medicine", title1: "Success"),
        );
      }
    }
  }

  deleteMedicine(BuildContext context, String id) async {
    bool check = await MedicineService.instance.deleteMedicine(context, id: id);
    if (check) {
      selectMedcine.value = 0;
      MedicineService.instance.listMedicine
          .removeWhere((element) => element.id == id);
      Get.back();
      Get.dialog(
        const SuccessDialog(question: "Delete Medicine", title1: "Success"),
      );
    }
  }

  editMedicine(BuildContext context, Uint8List? image) async {
    if (rxnameController.value.text == "" ||
        rxdescriptionController.value.text == "" ||
        rxpriceController.value.text == "") {
      Get.dialog(const ErrorDialog(
          question: 'Edit Medicine', title1: "Field is Null"));
    } else {
      String imageUrl = listMedicine[selectMedcine.value].thumbnails;
      isLoadingEdit.value = true;
      if (image != null) {
        imageUrl = (await convertUti8ListToUrl(image, nameController.text)) ??
            listMedicine[selectMedcine.value].thumbnails;
      }
      // ignore: use_build_context_synchronously
      Medicine? temp = await MedicineService.instance.editMedcine(
        context,
        id: listMedicine[selectMedcine.value].id,
        thumbnails: imageUrl,
        price: double.parse(rxpriceController.value.text),
        type: listType.value[selectTypeEdit.value],
        description: rxdescriptionController.value.text,
        name: rxnameController.value.text,
      );
      if (temp != null) {
        // MedicineService.instance.listMedicine.add(temp);
        MedicineService.instance.listMedicine[selectMedcine.value] = temp;
        isLoadingEdit.value = false;
        Get.dialog(
          const SuccessDialog(question: "Edit Medicine", title1: "Success"),
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    listMedicine.value = MedicineService.instance.listMedicine;
    listType.value.clear();
    for (var item in listMedicine) {
      if (!(listType.value.contains(item.type))) {
        listType.value.add(item.type);
      }
    }
    if (listMedicine.isNotEmpty) {
      funcselectMedincine(0);
    }
  }
}
