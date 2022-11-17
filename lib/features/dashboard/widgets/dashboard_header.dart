import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.width,
  });
  final double width;

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
          const Icon(
            Icons.notifications_outlined,
            size: 25,
          ),
          SizedBox(
            width: width,
            child: const ListTile(
              minVerticalPadding: 20,
              dense: true,
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
    );
  }
}
