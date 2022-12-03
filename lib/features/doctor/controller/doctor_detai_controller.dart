import 'package:get/get.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';

class DoctorDetailController extends GetxController {
  Department getDepartMent(String id, List<Department> list) =>
      list.firstWhere((element) => element.id == id);
  Doctor1 doctor = Get.arguments['doctor'] as Doctor1;
}
