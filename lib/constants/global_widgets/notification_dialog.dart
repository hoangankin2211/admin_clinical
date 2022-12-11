import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNotificationDialog extends StatelessWidget {
  const CustomNotificationDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title; 
  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Badge(
        position: BadgePosition.topStart(
          top: -45,
          start: 150 - 45,
        ),
        badgeColor: Colors.white,
        padding: const EdgeInsets.all(10),
        stackFit: StackFit.passthrough,
        elevation: 0,
        badgeContent: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.blueGrey[50],
          child: Image.asset(
            'assets/images/checked.png',
            height: 35,
            width: 35,
          ),
        ),
        child: SizedBox(
          height: 300,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                width: Get.mediaQuery.size.width * 0.7,
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      fixedSize: const Size(120, 40),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => Get.back(result: false),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      fixedSize: const Size(120, 40),
                      backgroundColor: Colors.red[300],
                      elevation: 0,
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
