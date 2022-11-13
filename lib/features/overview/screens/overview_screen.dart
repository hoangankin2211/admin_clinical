import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
          const Text(
            'Welcome, Dr.Stephen',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Have a nice at great work',
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const TableFieldCard(data: [
            'Patient Name',
            'Patient Id',
            'Date',
            'Gender',
            'Diseases',
            'Status'
          ]),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const SaleReportCard(
                  name: 'Hoang Ankin',
                  id: '20120483',
                  date: '13/11/2022',
                  gender: 'Male',
                  diseases: 'Nothing',
                  status: 'Out-Patient',
                );
              },
              itemCount: 5,
              cacheExtent: 5,
            ),
          ),
        ],
      );
    });
  }
}

class SaleReportCard extends StatelessWidget {
  const SaleReportCard({
    super.key,
    required this.name,
    required this.id,
    required this.date,
    required this.gender,
    required this.diseases,
    required this.status,
  });
  final String name;
  final String id;
  final String date;
  final String gender;
  final String diseases;
  final String status;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> data = {
      'name': name,
      'id': id,
      'date': date,
      'gender': gender,
      'diseases': diseases,
      'status': status,
    };
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.1),
          color: Colors.white,
          borderRadius: AppDecoration.primaryRadiusBorder),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'images/fake_avatar.jpg',
              fit: BoxFit.cover,
              height: 35,
              width: 35,
            ),
          ),
          const SizedBox(width: 5),
          ...data.entries
              .map(
                (e) => Expanded(
                  child: Text(
                    e.value,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.more_vert_outlined,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class TableFieldCard extends StatelessWidget {
  const TableFieldCard({super.key, required this.data});
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey[200]!, width: 0.1),
          color: const Color.fromARGB(255, 226, 231, 233),
          borderRadius: AppDecoration.primaryRadiusBorder),
      child: Row(
        children: [
          const SizedBox(
            width: 35,
          ),
          ...data
              .map(
                (e) => Expanded(
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
