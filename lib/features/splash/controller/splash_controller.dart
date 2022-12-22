import 'package:admin_clinical/routes/name_route.dart';
import 'package:get/get.dart';

import '../../../services/auth_service/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // await Future.delayed(const Duration(seconds: 5), () async {
    //   gotoNextScreen();
    // });
    bool check = await AuthService.instance.getUserData();
    if (check) {
      // bool check1 = await DataService.instance.fetchAllData();
      // if (check1) {
      Get.offAllNamed(PageName.dashBoard);
      // }
    } else {
      Get.offAllNamed(PageName.loginScreen);
    }
  }

  // Future<void> gotoNextScreen() async {
  //   if (AuthService.instance.isLogin) {
  //     Get.offAllNamed(RouteNames.dashboardScreen);
  //   } else {
  //     Get.offAllNamed(RouteNames.introScreen);
  //   }
  // }
}
