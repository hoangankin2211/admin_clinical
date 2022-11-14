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

  final List<Map<String, String>> data = [
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
      'id': '20120483',
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
      'id': '20120483',
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
      'id': '20120483',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
  ];

  void applyEntries(int value) {
    if (value >= 1 && value <= data.length) {
      numberOfEntries.value = value;
    }
  }

  late var numberOfEntries = (data.length - 1 > 5 ? 6 : data.length).obs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: AppDecoration.primaryRadiusBorder),
                ),
                onPressed: () {
                  Get.dialog(
                    AddPatientDialog(
                      height: constraints.maxHeight * 0.8,
                      width: constraints.maxWidth * 0.5,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShowEntriesWidget(
                applyEntries: applyEntries,
                numberOfEntries: numberOfEntries.value - 1,
                width: constraints.maxWidth * 0.03,
                height: constraints.maxHeight * 0.05,
                maxEntries: data.length - 1,
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: AppDecoration.primaryRadiusBorder,
                        side:
                            const BorderSide(color: Colors.grey, width: 0.3))),
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
                  hint:
                      DateFormat().add_yMd().format(DateTime.now()).toString(),
                  iconData: Icons.calendar_month_outlined,
                ),
              ),
            ],
          ),
          SizedBox(
            height: numberOfEntries.value * 100,
            child: Obx(() => ListView.builder(
                  itemExtent: 60,
                  itemBuilder: (context, index) => PatientListRow(
                    name: data[index]['name']!,
                    id: data[index]['id']!,
                    date: data[index]['date']!,
                    gender: data[index]['gender']!,
                    diseases: data[index]['diseases']!,
                    status: data[index]['status']!,
                    payment: data[index]['payment']!,
                    avt: 'images/fake_avatar.jpg',
                    color: index == 0 ? Colors.blueGrey[50]! : Colors.white,
                  ),
                  itemCount: numberOfEntries.value,
                )),
          ),
        ],
      );
    });
  }
}

class AddPatientDialog extends StatelessWidget {
  const AddPatientDialog(
      {super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(15),
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
                children: [
                  Text(
                    'Add New Patient',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.clear_outlined,
                      color: Colors.grey[350],
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[350]!,
                thickness: 0.5,
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
                      width: width * 0.4,
                      title: 'Phone Number',
                      hint: '123456'),
                ],
              ),
              CustomTextFormField(
                width: width,
                title: 'Symptom',
                hint: 'Describe your symptom',
                maxLine: 10,
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
    required this.width,
  });
  final String title;
  final double width;
  final int? maxLine;
  final String? hint;
  final Icon? trailingIcon;

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
            fontWeight: FontWeight.w500,
          ),
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.grey[350]!, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: AppDecoration.primaryRadiusBorder,
            borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
          ),
          suffixIcon: trailingIcon,
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
          style: Theme.of(context).textTheme.headline3,
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
