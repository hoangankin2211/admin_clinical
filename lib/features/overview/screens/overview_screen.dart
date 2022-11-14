import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final List<Map<String, String>> newPatientTableData = [
    {
      'name': 'Patient Name',
      'id': 'Patient Id',
      'date': 'Date',
      'gender': 'Gender',
      'diseases': 'Diseases',
      'status': 'Status'
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const Icon(
                  Icons.notifications_outlined,
                  size: 25,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.18,
                  child: const ListTile(
                    horizontalTitleGap: 10,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 217, 236, 246),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Stephen Conley",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Staff Admin',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Welcome, Dr.Stephen',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline2,
            ),
            const Text(
              'Have a nice at great work',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'Recenet Patient',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('View more',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) => CurrentPatientTableRow(
                  name: newPatientTableData[index]['name']!,
                  id: newPatientTableData[index]['id']!,
                  date: newPatientTableData[index]['date']!,
                  gender: newPatientTableData[index]['gender']!,
                  diseases: newPatientTableData[index]['diseases']!,
                  status: newPatientTableData[index]['status']!,
                  avt: 'images/fake_avatar.jpg',
                  color: index == 0 ? Colors.blueGrey[50]! : Colors.white,
                ),
                itemCount: newPatientTableData.length,
              ),
            ),
            StatisticPatient(
              width: constraints.maxWidth * 0.22,
            ),
          ],
        ),
      );
    });
  }
}

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
