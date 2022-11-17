import 'package:admin_clinical/features/doctor/screens/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/btn_with_icon.dart';
import '../../../constants/global_widgets/header_list_item.dart';
import '../../../constants/global_widgets/list_item.dart';
import '../widgets/dialog_add_new_doctor.dart';
import '../widgets/dialog_select_filter.dart';

List<Map<String, dynamic>> fakeData = [
  {
    "index": 0,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Minh Hung",
    "type": "Dentist",
    "date": DateTime.now(),
    "exp": 10,
    "ratings": 4.8,
  },
  {
    "index": 1,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Truong Huynh Duc Hoang",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 2,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Trung Hieu",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 3,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Phan Thien Nhan",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 2,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Trung Hieu",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 3,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Phan Thien Nhan",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 2,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Trung Hieu",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 3,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Phan Thien Nhan",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 2,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Trung Hieu",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 3,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Phan Thien Nhan",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 2,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673146/Macbool%20air%20pro%2022220/thsm0tejxhakjnc1nedk.jpg",
    "name": "Nguyen Trung Hieu",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  },
  {
    "index": 3,
    "image":
        "https://res.cloudinary.com/ddopvilpr/image/upload/v1665673142/Macbool%20air%20pro%2022220/a3gz4jsve2omrw5c4gtv.jpg",
    "name": "Phan Thien Nhan",
    "type": "Nerontist",
    "date": DateTime.now(),
    "exp": 8,
    "ratings": 2.8,
  }
];

class ViewAllDoctor extends StatelessWidget {
  final VoidCallback tapBackPage;
  ViewAllDoctor({super.key, required this.tapBackPage});
  RxInt select = 0.obs;
  RxList<String> listFilter = ["Dentist"].obs;
  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraits) => Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchField(widthDevice, context),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: _doctorListField(),
                      ),
                      const SizedBox(width: 10.0),
                      Obx(
                        () => _profileFastView(fakeData, context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _profileFastView(
      List<Map<String, dynamic>> fakeData, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              border: Border.all(width: 1, color: AppColors.primaryColor),
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.headline1TextColor.withOpacity(0.2),
                          blurRadius: 10.0),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(fakeData[select.value]["image"]),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${fakeData[select.value]["exp"]} Years",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 0.2,
                      color: Colors.blueGrey,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellowAccent),
                          Text(
                            '${fakeData[select.value]["ratings"]} rating',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  fakeData[select.value]["name"],
                  style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  fakeData[select.value]["type"],
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                const ReadMoreText(
                  "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                  trimLines: 4,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BtnWithIcon(
                          checkExpaned: true,
                          title: "Delete Doctor",
                          icon: Icons.delete,
                          color: Colors.red.withOpacity(0.6),
                          callBack: () {
                            bool isDelete = false;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  title: const Text('Are you sure ?'),
                                  content: const Text(
                                      'Do you want to remove the doctor from the list ? '),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        isDelete = true;
                                        Get.back();
                                      },
                                      child: const Text('YES'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        isDelete = false;
                                        Get.back();
                                      },
                                      child: const Text('NO'),
                                    ),
                                  ],
                                );
                              },
                            ).then((value) {
                              return isDelete;
                            });
                          }),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: BtnWithIcon(
                          checkExpaned: true,
                          title: "Edit Doctor",
                          icon: Icons.edit,
                          color: Colors.green.withOpacity(0.6),
                          callBack: () {}),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: BtnWithIcon(
                          checkExpaned: true,
                          title: "View Doctor",
                          icon: Icons.view_agenda,
                          color: Colors.blue.withOpacity(0.6),
                          callBack: () => Get.to(
                              () => Material(child: DoctorProfileScreen()))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _doctorListField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "866 found",
              style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Obx(
              () => RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                  children: [
                    const TextSpan(
                        text: "Filter: ",
                        style: TextStyle(color: AppColors.headline1TextColor)),
                    ...listFilter.value.map(
                      (e) => TextSpan(
                          text: ' $e',
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        const HeaderListItem(titles: [
          "Doctor",
          "Medical department",
          "Date Born",
          "Experience",
          "Ratings"
        ]),
        const SizedBox(height: 10.0),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ...fakeData.map(
                (e) => InkWell(
                  onTap: () => select.value = e["index"],
                  child: ListItem(
                    widgets: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.headline1TextColor
                                        .withOpacity(0.2),
                                    blurRadius: 10.0),
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    e["image"],
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ' ${e["name"]}',
                              style: const TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        e["type"],
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        DateFormat().add_yMd().format(e["date"]),
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        "${e["exp"]} Years",
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellowAccent),
                          Text(
                            '${e["ratings"]} rating',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  Row _searchField(double widthDevice, BuildContext context) {
    return Row(
      children: [
        BtnWithIcon(
          title: "Back",
          icon: Icons.arrow_back_ios,
          color: Colors.red.withOpacity(0.5),
          callBack: tapBackPage,
        ),
        const SizedBox(width: 10.0),
        Container(
          width: widthDevice / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.1),
                  blurRadius: 10.0),
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
          title: "Add new Doctor",
          icon: Icons.add,
          color: AppColors.primaryColor.withOpacity(0.5),
          callBack: () async => await showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: DialogAddNewDoctor(),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        BtnWithIcon(
          title: "Filter",
          icon: Icons.filter,
          color: AppColors.primaryColor.withOpacity(0.5),
          callBack: () async => await showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: DialogSelectFilter(
                callBack: (title) {
                  listFilter.value[0] = title;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
