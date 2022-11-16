import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';

// ignore: must_be_immutable
class StatisticPatient extends StatelessWidget {
  StatisticPatient({super.key, required this.width});
  final double width;
  var dropDownValue = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Patients',
                style: Theme.of(context).textTheme.headline2,
              ),
              Obx(
                () => DropdownButton<int>(
                  items: const [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('13/11/2022'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('14/11/2022'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('15/11/2022'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('16/11/2022'),
                    ),
                  ],
                  value: dropDownValue.value,
                  onChanged: (value) {
                    dropDownValue.value = value ?? 0;
                  },
                  elevation: 3,
                  borderRadius: AppDecoration.primaryRadiusBorder,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: AppDecoration.primaryRadiusBorder,
                color: Colors.white,
                boxShadow: AppDecoration.elevationContainer),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  dense: true,
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '100',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  subtitle: const Text('New Patient'),
                  trailing: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.trending_up_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          ' 15%',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  dense: true,
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '100',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  subtitle: const Text('Old Patient'),
                  trailing: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.trending_down_outlined,
                          color: Colors.green,
                        ),
                        Text(
                          ' 15%',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
