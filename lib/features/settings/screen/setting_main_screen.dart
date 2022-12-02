import 'package:admin_clinical/features/settings/controller/settings_controller.dart';
import 'package:admin_clinical/features/settings/widgets/change_password_tab.dart';
import 'package:admin_clinical/features/settings/widgets/general_tab.dart';
import 'package:admin_clinical/features/settings/widgets/notification_setting_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingMainScreen extends StatefulWidget {
  const SettingMainScreen({super.key});

  @override
  State<SettingMainScreen> createState() => _SettingMainScreenState();
}

class _SettingMainScreenState extends State<SettingMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController =
      TabController(length: 3, vsync: this, initialIndex: 0);

  final settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Settings',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: TabBar(
                controller: tabController,
                padding: const EdgeInsets.only(bottom: 20),
                tabs: const [
                  Tab(
                    height: 40,
                    child: Text(
                      'General Settings',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Text(
                      'Password Settings',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    height: 40,
                    child: Text(
                      'Notification Settings',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  const GeneralSettingsTab(),
                  ChangePasswordTab(),
                  NotificationSettingTab(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
