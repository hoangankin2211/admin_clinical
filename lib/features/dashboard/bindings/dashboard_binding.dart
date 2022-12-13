import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() async {
    // await Get.putAsync(() => Future.value(DashboardController()));
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
