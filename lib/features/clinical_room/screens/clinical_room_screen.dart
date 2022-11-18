import 'package:admin_clinical/constants/global_widgets/header_list_item.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/btn_with_icon.dart';

class ClinicalRoom extends StatelessWidget {
  ClinicalRoom({super.key});
  RxList<Map<String, dynamic>> fakeDataBed = [
    {
      "id": 117,
      "patient": "Nguyen Minh Hung",
      "image": 'assets/images/doctor2.png',
    },
    {
      "id": 113,
      "patient": "Nguyen Minh Man",
      "image": 'assets/images/doctor3.png',
    },
    {
      "id": 114,
      "patient": "",
      "image": 'assets/images/doctor1.png',
    },
    {
      "id": 115,
      "patient": "Nguyen Minh Hieu",
      "image": 'assets/images/doctor2.png',
    },
    {
      "id": 116,
      "patient": "Nguyen Minh Nhan",
      "image": 'assets/images/doctor3.png',
    },
    {
      "id": 117,
      "patient": "",
      "image": 'assets/images/doctor1.png',
    },
    {
      "id": 118,
      "patient": "Nguyen Minh Nguyen",
      "image": 'assets/images/doctor2.png',
    },
    {
      "id": 119,
      "patient": "Nguyen Minh Ton",
      "image": 'assets/images/doctor3.png',
    },
    {
      "id": 120,
      "patient": "",
      "image": 'assets/images/doctor2.png',
    },
  ].obs;
  RxList<Map<String, dynamic>> fakeData = [
    {
      "id": 1,
      "name": "Dentists",
      "er": 300,
      "ner": 100,
    },
    {
      "id": 2,
      "name": "Neurology",
      "er": 200,
      "ner": 80,
    },
    {
      "id": 3,
      "name": "Opthalmology",
      "er": 320,
      "ner": 200,
    },
    {
      "id": 4,
      "name": "ENT department",
      "er": 150,
      "ner": 100,
    },
    {
      "id": 5,
      "name": "Dentists",
      "er": 200,
      "ner": 100,
    },
    {
      "id": 3,
      "name": "Opthalmology",
      "er": 320,
      "ner": 200,
    },
    {
      "id": 4,
      "name": "ENT department",
      "er": 150,
      "ner": 100,
    },
    {
      "id": 5,
      "name": "Dentists",
      "er": 200,
      "ner": 100,
    },
    {
      "id": 3,
      "name": "Opthalmology",
      "er": 320,
      "ner": 200,
    },
    {
      "id": 4,
      "name": "ENT department",
      "er": 150,
      "ner": 100,
    },
    {
      "id": 5,
      "name": "Dentists",
      "er": 200,
      "ner": 100,
    },
    {
      "id": 3,
      "name": "Opthalmology",
      "er": 320,
      "ner": 200,
    },
    {
      "id": 4,
      "name": "ENT department",
      "er": 150,
      "ner": 100,
    },
    {
      "id": 5,
      "name": "Dentists",
      "er": 200,
      "ner": 100,
    }
  ].obs;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          _searchField(MediaQuery.of(context).size.width, context),
          const SizedBox(height: 20.0),
          Expanded(
            child: Row(children: [
              Expanded(
                flex: 5,
                child: _listField(),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: _listRoomViewField(),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Container _listRoomViewField() {
    return Container(
      margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Room View",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "List Room",
                style: TextStyle(
                  color: AppColors.primarySecondColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              primary: false,
              crossAxisCount: 2,
              children: <Widget>[
                ...fakeDataBed.map((element) => Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.headline1TextColor.withOpacity(0.3),
                            blurRadius: 10.0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.headline1TextColor
                                      .withOpacity(0.3),
                                  blurRadius: 10.0,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(element["patient"] != ""
                                    ? element["image"]
                                    : 'assets/images/google.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            element["patient"] != ""
                                ? "Patient: ${element["patient"]}"
                                : "Empty Bed",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            "Bed: ${element["id"]}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: AppColors.primaryColor),
                                      child: const Text(
                                        "View",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {},
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              width: double.infinity,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
              child: const Text(
                "Edit Room",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _listField() {
    return Column(
      children: [
        const HeaderListItem(
          checkHeader: true,
          titles: [
            "ID",
            "Name",
            "Empy Bed",
            "No Empty Bed",
          ],
        ),
        const SizedBox(height: 10.0),
        ...fakeData.value.map((element) => InkWell(
              onTap: () {},
              child: ListItem(
                widgets: [
                  Text(
                    element["id"].toString(),
                    style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Text(
                    element["name"],
                    style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.bed, color: Colors.green, size: 20.0),
                      Text(
                        ' ${element["er"]}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.bed, color: Colors.red, size: 20.0),
                      Text(
                        ' ${element["ner"]}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                ],
                checkHeader: true,
              ),
            ))
      ],
    );
  }

  Row _searchField(double widthDevice, BuildContext context) {
    return Row(
      children: [
        Container(
          width: widthDevice / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.headline1TextColor.withOpacity(0.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              const Icon(Icons.search, color: AppColors.headline1TextColor),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Doctor.....",
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        BtnWithIcon(
          title: "Add new Room",
          icon: Icons.add,
          color: AppColors.primaryColor.withOpacity(0.5),
          callBack: () {},
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }
}
