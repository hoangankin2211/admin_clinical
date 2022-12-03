import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/doctor/controller/doctor_main_controller.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_profile_screen.dart';
import 'package:admin_clinical/models/department.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/btn_with_icon.dart';
import '../../../constants/global_widgets/header_list_item.dart';
import '../../../constants/global_widgets/list_item.dart';
import '../../../constants/utils.dart';
import '../../../models/doctor.dart';
import '../../../services/data_service/data_service.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../widgets/dialog_add_new_doctor.dart';
import '../widgets/dialog_edit_doctor.dart';
import '../widgets/dialog_select_filter.dart';

class ViewAllDoctor extends StatelessWidget {
  final VoidCallback tapBackPage;
  ViewAllDoctor({super.key, required this.tapBackPage});
  RxInt select = 0.obs;
  RxList<String> listFilter = ["Dentist"].obs;
  final controller = Get.find<DoctorMainController>();
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
                        () => _profileFastView(context),
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

  Expanded _profileFastView(BuildContext context) {
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
            child: (controller.listDoctor.value.isNotEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 160,
                        width: 160,
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
                            image: NetworkImage(controller.listDoctor
                                .value[controller.selectDoctor.value].avt!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "${controller.listDoctor.value[controller.selectDoctor.value].experience} Years",
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
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          Expanded(
                            child: Row(
                              children: const [
                                Icon(Icons.star, color: Colors.yellowAccent),
                                Text(
                                  '4.9 rating',
                                  style: TextStyle(
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
                        controller.listDoctor
                            .value[controller.selectDoctor.value].name!,
                        style: const TextStyle(
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        controller
                            .getDepartMent(
                                controller
                                    .listDoctor
                                    .value[controller.selectDoctor.value]
                                    .departMent!,
                                controller.listDepartMent.value)
                            .name!,
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      const SizedBox(height: 10.0),
                      ReadMoreText(
                        controller.listDoctor
                            .value[controller.selectDoctor.value].description!,
                        trimLines: 4,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' Show more',
                        trimExpandedText: ' Show less',
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        lessStyle: const TextStyle(
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
                                              controller.deleteDoctor(
                                                  context,
                                                  controller
                                                      .listDoctor
                                                      .value[controller
                                                          .selectDoctor.value]
                                                      .iDBS!);
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
                                callBack: () {
                                  controller.initAllDataDialogEdit();
                                  Get.dialog(Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: DialogEditDoctor(),
                                  ));
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: BtnWithIcon(
                              checkExpaned: true,
                              title: "View Doctor",
                              icon: Icons.view_agenda,
                              color: Colors.blue.withOpacity(0.6),
                              callBack: () => Get.toNamed(
                                PageName.doctorDetailScreen,
                                arguments: {
                                  'doctor': controller.listDoctor
                                      .value[controller.selectDoctor.value]
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Column _doctorListField() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              "${controller.listSearchDoctor.value.length} found",
              style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
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
                        style: const TextStyle(color: AppColors.primaryColor)),
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
            child: GetBuilder<DoctorMainController>(
                id: 'listDoctor',
                autoRemove: false,
                assignId: true,
                builder: (_controller) =>
                    (_controller.listSearchDoctor.value.isEmpty)
                        ? Column(children: [
                            for (int i = 0;
                                i < _controller.listDoctor.value.length;
                                i++)
                              InkWell(
                                onTap: () => controller.selectDoctor.value = i,
                                child: DoctorRowIte(
                                  doctor: _controller.listDoctor.value[i],
                                  departMent: controller
                                      .getDepartMent(
                                          _controller
                                              .listDoctor.value[i].departMent!,
                                          _controller.listDepartMent.value)
                                      .name!,
                                ),
                              )
                          ])
                        : Column(children: [
                            for (int i = 0;
                                i < _controller.listSearchDoctor.value.length;
                                i++)
                              InkWell(
                                onTap: () => controller.selectDoctor.value = i,
                                child: DoctorRowIte(
                                  doctor: _controller.listSearchDoctor.value[i],
                                  departMent: controller
                                      .getDepartMent(
                                          _controller.listSearchDoctor.value[i]
                                              .departMent!,
                                          _controller.listDepartMent.value)
                                      .name!,
                                ),
                              )
                          ]))),
      )
    ]);
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
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.fetchSearchDoctor(context, value);
                  },
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

class DoctorRowIte extends StatelessWidget {
  DoctorRowIte({
    Key? key,
    required this.doctor,
    required this.departMent,
  }) : super(key: key);

  final Doctor1 doctor;
  final String departMent;
  @override
  Widget build(BuildContext context) {
    return ListItem(
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
                      color: AppColors.headline1TextColor.withOpacity(0.2),
                      blurRadius: 10.0),
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      doctor.avt!,
                    )),
              ),
            ),
            Expanded(
              child: Text(
                ' ${doctor.name}',
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
          departMent,
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        Text(
          DateFormat().add_yMd().format(doctor.dateBorn!),
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        Text(
          "${doctor.experience} Years",
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        Row(
          children: const [
            Icon(Icons.star, color: Colors.yellowAccent),
            Text(
              '4.5 rating',
              style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
