import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/models/medicine.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  RxList<Medicine1> listMedicine = <Medicine1>[].obs;
  List<String> listType = [];
  List<String> listUnit = [
    'Pill',
    'Pack',
    'Tablet',
    'potion',
  ];
  // TextEdittingController
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
    listType.clear();
    for (var item in listMedicine) {
      if (!(listType.contains(item.type))) {
        listType.add(item.type);
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
      Medicine1? temp = await MedicineService.instance.updateAMountMedicine(
          context,
          id: listMedicine.value[index].id,
          amount: amount.value);
      if (temp != null) {
        MedicineService.instance.listMedicine.value[index] = temp;
        listMedicine.value[index] = temp;
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
      String imageUrl =
          'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=';
      if (image != null) {
        imageUrl = (await convertUti8ListToUrl(image, nameController.text)) ??
            'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk=';
      }
      // ignore: use_build_context_synchronously
      Medicine1? temp = await MedicineService.instance.insertNewMedcine(
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
      MedicineService.instance.listMedicine
          .removeWhere((element) => element.id == id);
      Get.back();
      Get.dialog(
        const SuccessDialog(question: "Insert new Medicine", title1: "Success"),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    listMedicine.value = MedicineService.instance.listMedicine;
  }
}
