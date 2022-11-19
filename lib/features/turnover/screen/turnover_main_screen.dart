import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/screens/invoice_view_screen.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/features/patient/widgets/show_entries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/button_mouse_region.dart';
import '../../patient/controller/patient_page_controller.dart';
import '../widgets/grid_invoice_item.dart';
import '../widgets/list_invoice_item.dart';
import '../widgets/row_expanded.dart';

List<String> headerTitle = [
  "Invoice ID",
  "Category",
  "Created on",
  "Invoice to",
  "Amount",
  "Status",
  "Action",
];

class TurnoverMainScreen extends StatelessWidget {
  TurnoverMainScreen({super.key});
  final patientPageController = Get.put(PatientPageController());
  final invoiceController = Get.find<InvoiceController>();
  List<Widget> listHeader = [
    ...headerTitle.map(
      (e) => Row(
        children: [
          Text(
            e,
            style: const TextStyle(
              color: AppColors.backgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.swap_vert_rounded,
              color: AppColors.primarySecondColor,
            ),
          ),
        ],
      ),
    )
  ];

  List<Map<String, dynamic>> listFilter = [
    {
      "icon": Icons.person_add_alt_outlined,
      "title": "Select User",
      "onTap": SelectUserDialog(),
    },
    {
      "icon": Icons.date_range,
      "title": "Select Date",
      "onTap": SelectDateDialog(),
    },
    {
      "icon": Icons.book,
      "title": "Select Status",
      "onTap": SelectStatusDialog(),
    },
    {
      "icon": FontAwesome.save,
      "title": "By category",
      "onTap": SelectCategoryDialog(),
    },
  ];

  List<Map<String, dynamic>> listInvoices = [
    {
      "icon": Icons.file_copy_outlined,
      "title": "All Invoices",
      "data": 878797,
      "data1": 50,
    },
    {
      "icon": Icons.folder_copy_outlined,
      "title": "Paid Invoices",
      "data": 45884,
      "data1": 60,
    },
    {
      "icon": Icons.paid_outlined,
      "title": "All Invoices",
      "data": 878797,
      "data1": 70,
    },
    {
      "icon": Icons.security_outlined,
      "title": "Cancelled Invoices",
      "data": 88797,
      "data1": 80,
    },
  ];

  RxList<Map<String, dynamic>> listFakeData = [
    {
      "id": "IN093439#@11",
      "cat": "Marketing",
      "date": DateTime.now(),
      "image": "assets/images/doctor1.png",
      "name": "Russell Copeland",
      "amount": 3.47,
      "status": 0,
    },
    {
      "id": "IN093439#@13",
      "cat": "Software",
      "date": DateTime.now(),
      "image": "assets/images/doctor2.png",
      "name": "Jennifer Floyd",
      "amount": 5.200,
      "status": 1,
    },
    {
      "id": "IN093439#@10",
      "cat": "Food",
      "date": DateTime.now(),
      "image": "assets/images/doctor2.png",
      "name": "Karlene Chaidez",
      "amount": 1.22,
      "status": 1,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
    {
      "id": "IN093439#@12",
      "cat": "Repairs",
      "date": DateTime.now(),
      "image": "assets/images/doctor3.png",
      "name": "Joseph Collins",
      "amount": 9.65,
      "status": 2,
    },
  ].obs;

  RxBool checkGrid = false.obs;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.primaryColor,
                  ),
                  child: const Icon(
                    FontAwesome.file,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  " Invoke",
                  style: TextStyle(
                    color: AppColors.primarySecondColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => checkGrid.value = false,
                    child: Icon(
                      Icons.list,
                      color: (!checkGrid.value)
                          ? AppColors.primaryColor
                          : AppColors.headline1TextColor,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  InkWell(
                    onTap: () => checkGrid.value = true,
                    child: Icon(
                      Icons.grid_view_outlined,
                      color: (checkGrid.value)
                          ? AppColors.primaryColor
                          : AppColors.headline1TextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          _listFilterField(context),
          const SizedBox(height: 20.0),
          _invoiceStatusField(),
          const SizedBox(height: 20.0),
          _invoiceListField(),
          const SizedBox(height: 10.0),
          _listInvoiceFIeld(constraints),
        ],
      ),
    );
  }

  Expanded _listInvoiceFIeld(BoxConstraints constraints) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.headline1TextColor.withOpacity(0.2),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowEntriesWidget(
              applyEntries: patientPageController.applyEntries,
              numberOfEntries: patientPageController.numberOfEntries.value - 1,
              width: constraints.maxWidth * 0.03,
              height: constraints.maxHeight * 0.05,
              maxEntries: patientPageController.data.value.length - 1,
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => Expanded(
                child: !checkGrid.value
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.headline1TextColor.withOpacity(0.2),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 0.4,
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: RowExpanded(
                                listWidget: listHeader,
                                listFlex: const [2, 1, 1, 2, 1, 1, 1],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  ...listFakeData.map(
                                    (e) => Column(
                                      children: [
                                        ListInvoiceItem(
                                          id: e["id"],
                                          category: e["cat"],
                                          date: DateTime.now(),
                                          image: e["image"],
                                          name: e["name"],
                                          amount: e["amount"],
                                          status: e["status"],
                                        ),
                                        const Divider(thickness: 0.7),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.count(
                        shrinkWrap: false,
                        crossAxisCount: 6,
                        children: <Widget>[
                          ...listFakeData.map(
                            (e) => GridInvoiceItem(e: e),
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _invoiceListField() {
    return Row(
      children: [
        ...listInvoices.map(
          (e) => Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.3),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(e['icon'],
                          color: AppColors.primarySecondColor.withOpacity(0.6),
                          size: 30.0),
                      Text(
                        "\$ ${e["data"]}",
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${e["title"]}  ${e["data1"]}",
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Padding _invoiceStatusField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          const Text(
            "All Invoice",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 20.0),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.settings_outlined,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 10.0),
          ButtonMouseRegion(
            color: AppColors.primaryColor,
            colorChange: Colors.yellow,
            child: Row(
              children: const [
                Icon(
                  Icons.add_circle_outline_sharp,
                  color: Colors.white,
                ),
                Text(
                  ' New Invoice',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            func: () => invoiceController.changePage(1),
          ),
        ],
      ),
    );
  }

  Container _listFilterField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ...listFilter.map(
            (e) => Expanded(
              child: InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: e['onTap'],
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        e["icon"],
                        color: AppColors.primaryColor,
                        size: 20.0,
                      ),
                      Text(
                        ' ${e["title"]}',
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  width: 0.2,
                  color: AppColors.primaryColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.show_chart,
                    color: AppColors.primaryColor,
                    size: 20.0,
                  ),
                  Text(
                    ' Generate Report',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectUserDialog extends StatelessWidget {
  SelectUserDialog({
    Key? key,
  }) : super(key: key);
  RxList<Map<String, dynamic>> name = [
    {
      "name": "Duc Hoang",
      "check": false.obs,
    },
    {
      "name": "Minh Hung",
      "check": false.obs,
    },
    {
      "name": "Trung Hieu",
      "check": false.obs,
    },
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Custom Search",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Obx(
            () => Expanded(
              child: ListView(
                children: [
                  ...name.map(
                    (e) => Row(
                      children: [
                        Checkbox(
                            value: e["check"].value,
                            onChanged: (value) => e["check"].value = value),
                        Expanded(
                          child: Text(
                            '   ${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(
                text: "Reset",
                onTap: () {},
                backgroundColor: AppColors.primaryColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(text: "Apply", onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class SelectDateDialog extends StatelessWidget {
  SelectDateDialog({
    Key? key,
  }) : super(key: key);

  List<String> dateFilter = [
    "Today",
    "Yesterday",
    "Last 7Days",
    "This month",
    "Last month",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Date Filter",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "From ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(Icons.calendar_month, color: Colors.grey)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "To ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(Icons.calendar_month, color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ...dateFilter.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ButtonMouseRegion(
                        color: AppColors.primaryColor,
                        colorChange: Colors.yellow,
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        func: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectStatusDialog extends StatelessWidget {
  SelectStatusDialog({
    Key? key,
  }) : super(key: key);
  RxList<Map<String, dynamic>> name = [
    {
      "name": "All Invoices",
      "check": false.obs,
    },
    {
      "name": "Paid",
      "check": false.obs,
    },
    {
      "name": "Overdude",
      "check": false.obs,
    },
    {
      "name": "Draft",
      "check": false.obs,
    },
    {
      "name": "Recuring",
      "check": false.obs,
    },
    {
      "name": "Cancelled",
      "check": false.obs,
    },
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "By Status",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: const [
              CustomTextFormField(
                hint: "Enter Custom Name",
                width: 280,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Obx(
            () => Expanded(
              child: ListView(
                children: [
                  ...name.map(
                    (e) => Row(
                      children: [
                        Checkbox(
                            value: e["check"].value,
                            onChanged: (value) => e["check"].value = value),
                        Expanded(
                          child: Text(
                            '   ${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(
                text: "Reset",
                onTap: () {},
                backgroundColor: AppColors.primaryColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(text: "Apply", onTap: () {}),
          ),
        ],
      ),
    );
  }
}

class SelectCategoryDialog extends StatelessWidget {
  SelectCategoryDialog({
    Key? key,
  }) : super(key: key);
  RxList<Map<String, dynamic>> name = [
    {
      "name": "Advertsting",
      "check": false.obs,
    },
    {
      "name": "Food",
      "check": false.obs,
    },
    {
      "name": "Marketing",
      "check": false.obs,
    },
    {
      "name": "Repairs",
      "check": false.obs,
    },
    {
      "name": "Software",
      "check": false.obs,
    },
    {
      "name": "Stationary",
      "check": false.obs,
    },
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category ",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: const [
              CustomTextFormField(
                hint: "Enter Custom Name",
                width: 280,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Obx(
            () => Expanded(
              child: ListView(
                children: [
                  ...name.map(
                    (e) => Row(
                      children: [
                        Checkbox(
                            value: e["check"].value,
                            onChanged: (value) => e["check"].value = value),
                        Expanded(
                          child: Text(
                            '   ${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(
                text: "Reset",
                onTap: () {},
                backgroundColor: AppColors.primaryColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(text: "Apply", onTap: () {}),
          ),
        ],
      ),
    );
  }
}
