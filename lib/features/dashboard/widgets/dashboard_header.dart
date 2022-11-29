import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

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
          PopupMenuButton<Menu>(
              child:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.itemOne,
                      child: NotificationItem(
                        mainTitle: 'You have new notification about patient',
                        time: DateTime.now(),
                        type: 9,
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemTwo,
                      child: NotificationItem(
                        mainTitle: 'You have new notification about patient',
                        time: DateTime.now(),
                        type: 9,
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemThree,
                      child: NotificationItem(
                        mainTitle: 'You have new notification abo patient',
                        time: DateTime.now(),
                        type: 9,
                      ),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.itemFour,
                      child: NotificationItem(
                        mainTitle: 'You have new notification about patient',
                        time: DateTime.now(),
                        type: 9,
                      ),
                    ),
                  ]),
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

class NotificationItem extends StatelessWidget {
  final String mainTitle;
  final DateTime time;
  final int type;
  const NotificationItem({
    Key? key,
    required this.mainTitle,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Container(
            width: 45.0,
            height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3), blurRadius: 5.0),
              ],
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/app_icon.png'),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.timelapse_rounded,
                        color: Colors.blue, size: 16.0),
                    Text(
                      DateFormat().add_yMMMEd().format(DateTime.now()),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
        const SizedBox(height: 3.0),
        const Divider(thickness: 1),
      ],
    );
  }
}
