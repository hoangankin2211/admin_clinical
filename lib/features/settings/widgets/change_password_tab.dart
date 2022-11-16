import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';

class ChangePasswordTab extends StatelessWidget {
  ChangePasswordTab({super.key});
  List<Map<String, dynamic>> data = [
    {
      'title': 'General email Notifications',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
    {
      'title': 'Emails for every ',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
    {
      'title': 'General email Notifications',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
    {
      'title': 'General email Notifications',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
    {
      'title': 'General email Notifications',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
    {
      'title': 'General email Notifications',
      'value': false.obs,
      'subtitle': 'Your main Email to receive notifications',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.2,
          ),
          borderRadius: AppDecoration.primaryRadiusBorder,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.blueGrey[100], height: 10, thickness: 0.6),
              SingleChildScrollView(
                child: Column(
                  children: ListTile.divideTiles(
                    color: Colors.blueGrey[100],
                    context: context,
                    tiles: data.map(
                      (element) => ListTile(
                        dense: true,
                        isThreeLine: true,
                        title: Text(
                          element['title'],
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        subtitle: Text(
                          element['subtitle'],
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[300],
                          ),
                        ),
                        trailing: Obx(
                          () => CupertinoSwitch(
                            activeColor: AppColors.primaryColor,
                            value: (element['value'] as RxBool).value,
                            onChanged: (value) {
                              (element['value'] as RxBool).value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
              Divider(color: Colors.blueGrey[100], height: 10, thickness: 0.6),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: constraints.maxWidth * 0.25,
                    child: TextButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      icon: const Icon(
                        Icons.check_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Save change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 35,
                    width: constraints.maxWidth * 0.2,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
