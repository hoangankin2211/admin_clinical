import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_profile_screen.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/fake_data.dart';

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
  ViewAllDoctor({super.key});
  RxInt select = 0.obs;
  RxList<String> listFilter = ["Dentist"].obs;
  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraits) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.blueGrey,
                      size: 20,
                    ),
                    hintText: 'Search Appointment, Patient, etc',
                    hintStyle: TextStyle(
                        color: Colors.blueGrey,
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
                width: constraits.maxWidth * 0.18,
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
                      color: Colors.blueGrey,
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
                    BtnWithIcon(
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
                    const SizedBox(width: 10.0),
                    BtnWithIcon(
                        title: "Edit Doctor",
                        icon: Icons.edit,
                        color: Colors.green.withOpacity(0.6),
                        callBack: () {}),
                    const SizedBox(width: 10.0),
                    BtnWithIcon(
                        title: "View Doctor",
                        icon: Icons.view_agenda,
                        color: Colors.blue.withOpacity(0.6),
                        callBack: () => Get.to(
                            () => Material(child: DoctorProfileScreen()))),
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
                          Text(
                            ' ${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
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

class DialogAddNewDoctor extends StatelessWidget {
  DialogAddNewDoctor({
    Key? key,
  }) : super(key: key);
  final _passController = TextEditingController();
  RxInt _value = 0.obs;
  final _rePassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.greyBackgroundCOlor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person,
                  color: AppColors.primaryColor, size: 30.0),
              const Text(
                " Add new Doctor",
                style: TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: AppColors.headline1TextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Divider(thickness: 1),
          const SizedBox(height: 20.0),
          Expanded(
            child: Row(children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(
                              child: CustomTextFormField(
                            title: "First Name",
                            width: double.infinity,
                            hint: "Enter First Name",
                            trailingIcon: Icon(Icons.person),
                          )),
                          SizedBox(width: 20.0),
                          Expanded(
                              child: CustomTextFormField(
                            title: "Last Name",
                            width: double.infinity,
                            hint: "Enter Last Name",
                            trailingIcon: Icon(Icons.person),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: const [
                          Expanded(
                              child: CustomTextFormField(
                            title: "UserName",
                            width: double.infinity,
                            hint: "Enter Username",
                            trailingIcon: Icon(Icons.person),
                          )),
                          SizedBox(width: 20.0),
                          Expanded(
                              child: CustomTextFormField(
                            title: "Email",
                            width: double.infinity,
                            hint: "Enter Email",
                            trailingIcon: Icon(Icons.person),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                              child: CustomPasswordField(
                                  controller: _passController,
                                  hintText: "Enter Password",
                                  labelText: "Password")),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: CustomPasswordField(
                                controller: _rePassController,
                                hintText: "Enter Re-Password",
                                labelText: "Confirm Password"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldIconBtn(
                              title: "Day of Birth",
                              width: double.infinity,
                              callBack: () {},
                              trailingIcon: const Icon(Icons.calendar_month),
                              hint: "Select Day of Birth",
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Obx(
                            () => Expanded(
                                child: Row(
                              children: [
                                const Text(
                                  "Gender:   ",
                                  style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                const Text(
                                  "Male",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Radio(
                                  value: 0,
                                  groupValue: _value.value,
                                  onChanged: (value) {
                                    _value.value = value!;
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const SizedBox(width: 40.0),
                                const Text(
                                  "Fe Male",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _value.value,
                                  onChanged: (value) {
                                    _value.value = value!;
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const CustomTextFormField(
                        title: "Address",
                        width: double.infinity,
                        hint: "Enter Address",
                        trailingIcon: Icon(Icons.location_on_sharp),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          const Expanded(
                              child: CustomTextFormField(
                            title: "Phone Number",
                            width: double.infinity,
                            hint: "Enter Phone Number",
                            trailingIcon: Icon(Icons.phone),
                          )),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: CustomTextFieldIconBtn(
                              title: "Country",
                              width: double.infinity,
                              callBack: () {},
                              trailingIcon: const Icon(Icons.arrow_drop_down),
                              hint: "Select Day of Country",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const CustomTextFormField(
                        title: "Description",
                        maxLine: 4,
                        width: double.infinity,
                        hint: "Enter Description",
                      )
                    ],
                  )),
              const SizedBox(width: 10),
              Container(
                  width: 0.3, height: double.infinity, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.2),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/fake_avatar.jpg',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.4)
                              ]),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black.withOpacity(0.2)),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "  Pick Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.primaryColor.withOpacity(0.7),
                          ),
                          child: const Text(
                            "Create Doctor",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class DialogSelectFilter extends StatelessWidget {
  final Function(String) callBack;
  DialogSelectFilter({
    Key? key,
    required this.callBack,
  }) : super(key: key);
  RxInt selectTop = 0.obs;
  RxInt selectRating = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.backgroundColor,
        border: Border.all(width: 1, color: Colors.blue),
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ratings",
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < FakeData.rating.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            selectRating.value = i;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (i == selectRating.value)
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: (i == selectRating.value)
                                      ? Colors.white
                                      : AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  FakeData.rating[i] == 6
                                      ? 'All'
                                      : FakeData.rating[i].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: (i == selectRating.value)
                                        ? Colors.white
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Medical Department",
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < FakeData.topData.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            selectTop.value = i;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (i == selectTop.value)
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor)),
                            child: Text(
                              FakeData.topData[i],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: (i == selectTop.value)
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                width: double.infinity,
                height: 35.0,
                child: CustomButton(
                    title: "Apply",
                    onPressed: () {
                      callBack(FakeData.topData[selectTop.value]);
                    }))
          ])),
    );
  }
}

class BtnWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback callBack;
  const BtnWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            Text(
              " $title",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final List<Widget> widgets;
  const ListItem({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ...widgets.map((e) => Expanded(child: e)),
        ],
      ),
    );
  }
}

class HeaderListItem extends StatelessWidget {
  final List<String> titles;
  const HeaderListItem({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ...titles.map(
            (e) => Expanded(
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final int maxLines;
  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    required this.labelText,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool checkShow = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: checkShow,
      controller: widget.controller,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: Colors.grey[350]!,
            fontWeight: FontWeight.w500,
            fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: AppDecoration.primaryRadiusBorder,
          borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              checkShow = !checkShow;
            });
          },
          child: Icon(
            (checkShow) ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}

class CustomTextFieldIconBtn extends StatelessWidget {
  const CustomTextFieldIconBtn({
    super.key,
    required this.title,
    this.maxLine,
    this.trailingIcon,
    this.hint,
    this.prefixWidget,
    required this.width,
    required this.callBack,
  });
  final String title;
  final double width;
  final int? maxLine;
  final String? hint;
  final Icon? trailingIcon;
  final Widget? prefixWidget;
  final VoidCallback callBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: maxLine,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey[350]!,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: AppDecoration.primaryRadiusBorder,
            borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
          ),
          suffixIcon: InkWell(onTap: callBack, child: trailingIcon),
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}
