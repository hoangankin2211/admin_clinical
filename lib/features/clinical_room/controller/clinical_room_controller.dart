import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/models/clinical_room.dart';
import 'package:admin_clinical/services/data_service/clinical_room_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/global_widgets/custom_dialog_error/error_dialog.dart';
import '../../../constants/global_widgets/custom_dialog_error/success_dialog.dart';

class ClinicalRoomController extends GetxController {
  RxList<ClinicalRoomModel> listClincalRoom = <ClinicalRoomModel>[].obs;
  RxBool isLoadingInsert = false.obs;
  RxString selectRoomId = "".obs;
  final textController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    listClincalRoom = ClinicalRoomService.instance.listClinicalRoom;
    if (listClincalRoom.isNotEmpty) {
      selectRoomId.value = listClincalRoom[0].id;
    }
    // roomSelect.value = listClincalRoom[9]
  }

  insertNewRoom(BuildContext context) async {
    if (textController.text == "") {
      Get.dialog(const ErrorDialog(
          question: 'Insert new Medicine', title1: "Name is Null"));
    } else {
      isLoadingInsert.value = true;
      ClinicalRoomModel? temp = await ClinicalRoomService.instance
          .insertClinicalRoom(context, name: textController.text);
      if (temp != null) {
        ClinicalRoomService.instance.listClinicalRoom.add(temp);
        isLoadingInsert.value = false;
        textController.clear();
        Get.back();
        Get.dialog(
          const SuccessDialog(
              question: "Insert new Clinical Room", title1: "Success"),
        );
      }
    }
  }
}
