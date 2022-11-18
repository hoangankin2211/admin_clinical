import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/widgets/examination_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../doctor/widgets/medical_exmamindation_item.dart';

// ignore: must_be_immutable
class MedicalExaminationTab extends StatelessWidget {
  MedicalExaminationTab({super.key});

  List<Map<String, dynamic>> fakeData = [
    {
      "id": "113",
      "date": DateTime.now(),
      "cr": "Phong Kham noi 1",
      "pn": "Truong Huynh Duc Hoang",
      "status": 1,
    },
    {
      "id": "114",
      "date": DateTime.now(),
      "cr": "Phong Kham noi 2",
      "pn": "Nguyen Minh Hung",
      "status": 1,
    },
    {
      "id": "115",
      "date": DateTime.now(),
      "cr": "Phong Kham noi 3",
      "pn": "Nguyen Trung Hieu",
      "status": 2,
    },
    {
      "id": "116",
      "date": DateTime.now(),
      "cr": "Phong Kham noi 4",
      "pn": "Phan Thien Nhan",
      "status": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDecoration.primaryPadding,
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: PatientInformationForm(),
                          ),
                          VerticalDivider(
                            color: Colors.blueGrey[400],
                            thickness: 0.3,
                          ),
                          Expanded(
                            child: RecordInformationForm(),
                          ),
                        ],
                      ),
                    ),
                    AppWidget.primaryDivider,
                    const SizedBox(height: 5),
                    Flexible(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.6,
                          child: ExaminationInformationForm(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppWidget.primaryDivider,
              Flexible(
                flex: 1,
                // height: constraints.maxHeight * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'ID',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Date Time',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Clinic',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Patient\'s name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return MedicalExaminationItem(
                            id: fakeData[index]["id"],
                            date: fakeData[index]["date"],
                            clinicRoom: fakeData[index]["cr"],
                            patientName: fakeData[index]["pn"],
                            status: fakeData[index]["status"],
                          );
                        },
                        itemCount: fakeData.length,
                        scrollDirection: Axis.vertical,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
