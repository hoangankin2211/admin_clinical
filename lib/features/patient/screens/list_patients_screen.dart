import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListPatientScreen extends StatelessWidget {
  ListPatientScreen({super.key});

  final Rx<List<Map<String, String>>> data = Rx<List<Map<String, String>>>([
    {
      'name': 'Patient Name',
      'id': 'Id',
      'date': 'Date',
      'gender': 'Gender',
      'diseases': 'Diseases',
      'status': 'Status',
      'payment': 'Payment',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120481',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120482',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120484',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120485',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
  ]);

  void applyEntries(int value) {
    if (value >= 1 && value <= data.value.length) {
      numberOfEntries.value = value;
    }
  }

  void removeEntries(int index) {
    numberOfEntries.value--;
    data.value.removeAt(index);
  }

  late var numberOfEntries =
      (data.value.length - 1 > 5 ? 6 : data.value.length).obs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patient List',
                  style: Theme.of(context).textTheme.headline2,
                ),
                TextButton.icon(
                  icon: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                  label: const Text(
                    'Add Patient',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: AppDecoration.primaryRadiusBorder),
                  ),
                  onPressed: () {
                    Get.dialog(
                      AddPatientDialog(
                        height: constraints.maxHeight * 0.8,
                        width: constraints.maxWidth * 0.45,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowEntriesWidget(
                  applyEntries: applyEntries,
                  numberOfEntries: numberOfEntries.value - 1,
                  width: constraints.maxWidth * 0.03,
                  height: constraints.maxHeight * 0.05,
                  maxEntries: data.value.length - 1,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                          side: const BorderSide(
                              color: Colors.grey, width: 0.3))),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.blueGrey,
                  ),
                  label: Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  child: FilterCategory(
                    title: 'Patient',
                    hint: 'Patient name, Patient id, etc',
                    iconData: Icons.search_outlined,
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: FilterCategory(
                    title: 'Category',
                    hint: 'All Category',
                    iconData: Icons.category_outlined,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FilterCategory(
                    title: 'Date of Joining',
                    hint: DateFormat()
                        .add_yMd()
                        .format(DateTime.now())
                        .toString(),
                    iconData: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: numberOfEntries.value * 60,
              child: Obx(
                () => ListView.builder(
                  itemExtent: 60,
                  itemCount: numberOfEntries.value,
                  itemBuilder: (context, index) => PatientListRow(
                    index: index,
                    removeEntries: removeEntries,
                    name: data.value[index]['name']!,
                    id: data.value[index]['id']!,
                    date: data.value[index]['date']!,
                    gender: data.value[index]['gender']!,
                    diseases: data.value[index]['diseases']!,
                    status: data.value[index]['status']!,
                    payment: data.value[index]['payment']!,
                    avt: 'images/fake_avatar.jpg',
                    color: index == 0 ? Colors.blueGrey[50]! : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class AddPatientDialog extends StatelessWidget {
  AddPatientDialog({super.key, required this.height, required this.width});
  final double height;
  final double width;

  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  late var phoneCode = dropDownItem.first.obs;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        height: height,
        width: width,
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Patient',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  InkWell(
                    onTap: Get.back,
                    child: Icon(
                      Icons.clear_outlined,
                      color: Colors.grey[350],
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[350]!,
                thickness: 0.6,
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'First Name',
                      hint: 'Enter your first Name'),
                  const Spacer(),
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'Last Name',
                      hint: 'Enter your last name'),
                ],
              ),
              CustomTextFormField(
                  width: width,
                  title: 'Location',
                  hint: 'Enter your current Address'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'Patient Email',
                      hint: 'email@gmail.com'),
                  const Spacer(),
                  CustomTextFormField(
                    prefixWidget: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => DropdownButton<String>(
                          underline: const SizedBox(),
                          value: phoneCode.value,
                          items: dropDownItem
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            phoneCode.value = value ?? '';
                          },
                        ),
                      ),
                    ),
                    width: width * 0.4,
                    title: 'Phone Number',
                    hint: '123456',
                  ),
                ],
              ),
              CustomTextFormField(
                width: width,
                title: 'Symptom',
                hint: 'Describe your symptom',
                maxLine: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: Get.back,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: Get.back,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.maxLine,
    this.trailingIcon,
    this.hint,
    this.prefixWidget,
    required this.width,
  });
  final String title;
  final double width;
  final int? maxLine;
  final String? hint;
  final Icon? trailingIcon;
  final Widget? prefixWidget;

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
          suffixIcon: trailingIcon,
          prefixIcon: prefixWidget,
        ),
      ),
    );
  }
}

class FilterCategory extends StatelessWidget {
  const FilterCategory({
    super.key,
    required this.title,
    required this.hint,
    required this.iconData,
  });
  final String title;
  final String hint;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.grey[400]!, fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                borderRadius: AppDecoration.primaryRadiusBorder,
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 0.05,
                ),
              ),
              suffixIcon: Icon(iconData)),
        ),
      ],
    );
  }
}

class ShowEntriesWidget extends StatelessWidget {
  ShowEntriesWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.numberOfEntries,
      required this.applyEntries,
      required this.maxEntries});
  final double height;
  final double width;
  final int numberOfEntries;
  final int maxEntries;
  final Function(int) applyEntries;

  late final TextEditingController controller =
      TextEditingController(text: numberOfEntries.toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Show',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: AppDecoration.primaryRadiusBorder,
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: height,
                  maxHeight: width,
                ),
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) => applyEntries(int.parse(value)),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (int.parse(controller.text) <= maxEntries) {
                        controller.text =
                            (int.parse(controller.text) + 1).toString();
                        applyEntries(int.parse(controller.text));
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (int.parse(controller.text) >= 0) {
                        controller.text =
                            (int.parse(controller.text) - 1).toString();
                        applyEntries(int.parse(controller.text));
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'entries',
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    );
  }
}
