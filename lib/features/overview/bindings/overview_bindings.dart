import 'package:admin_clinical/features/overview/controller/overview_controller.dart';
import 'package:get/get.dart';

class OverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OverviewController>(() => OverviewController());
  }
}
