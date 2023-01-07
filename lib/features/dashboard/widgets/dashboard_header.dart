import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
import 'package:admin_clinical/features/dashboard/widgets/setting_popup_item.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

import 'notification_item.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class DashboardHeader extends StatelessWidget {
  DashboardHeader({
    super.key,
    required this.width,
  });
  final double width;
  final controller = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                hintText: 'Search Appointment, Patient, etc',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Obx(() {
            return Align(
              alignment: Alignment.topRight,
              child: Badge(
                elevation: 1,
                badgeContent: Text(
                  NotificationService.instance.listNotification.length
                      .toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                badgeColor: Colors.red,
                child: PopupMenuButton<Menu>(
                  tooltip: "Notification",
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                  // Callback that sets the selected popup menu item.
                  onSelected: (Menu item) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    ...NotificationService.instance.listNotification.map(
                      (element) => PopupMenuItem<Menu>(
                        value: Menu.itemFour,
                        child: NotificationItem(
                          mainTitle: element.title!,
                          time: element.time!,
                          type: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(
            width: width,
            child: ListTile(
              minVerticalPadding: 20,
              dense: true,
              horizontalTitleGap: 10,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              isThreeLine: true,
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 217, 236, 246),
                backgroundImage: (AuthService.instance.user.avt.isNotEmpty)
                    ? NetworkImage(
                        AuthService.instance.user.avt,
                      ) as ImageProvider
                    : const AssetImage('assets/images/user.png'),
              ),
              title: Text(
                AuthService.instance.user.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                AuthService.instance.user.type,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              trailing: PopupMenuButton<Menu>(
                tooltip: "Setting",
                child: const Icon(Icons.arrow_drop_down, color: Colors.black),
                // Callback that sets the selected popup menu item.
                onSelected: (Menu item) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black38, blurRadius: 5.0)
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(controller.user!.avt),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Obx(
                          () => Text(
                            controller.user!.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          AuthService.instance.user.type,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        const Divider(thickness: 1),
                      ],
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: SettingPopupItem(
                      title: "Cai dat quyen rieng tu",
                      icon: Icons.settings,
                      press: () {},
                      type: 0,
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: SettingPopupItem(
                      title: "Tro giup ho tro",
                      icon: Icons.question_mark_outlined,
                      press: () {},
                      type: 0,
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    onTap: () => AuthService.instance.logOut(context),
                    value: Menu.itemOne,
                    child: SettingPopupItem(
                      title: "Log Out",
                      icon: Icons.logout,
                      press: () {},
                      type: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
