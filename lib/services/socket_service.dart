import 'dart:convert';

import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/api_link.dart';
import '../models/health_record.dart';
import '../models/notification.dart';
import '../models/patient.dart';
import 'auth_service/auth_service.dart';
import 'data_service/patient_service.dart';

class SocketService {
  SocketService._privateConstructor();

  static final SocketService instance = SocketService._privateConstructor();
  IO.Socket? _socket;

  IO.Socket get socket {
    print('initsocket');
    if (_socket == null) {
      _initSocket();
    }
    return _socket!;
  }

  void _initSocket() {
    _socket = IO.io(
      ApiLink.uri,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({
            'uniqueKey': UniqueKey().toString(),
            'userType': AuthService.instance.user.type,
            'userId': AuthService.instance.user.id,
          })
          .disableReconnection()
          .enableForceNewConnection() // necessary because otherwise it would reuse old connection
          .disableAutoConnect()
          .build(),
    );
    _socket!.connect();
  }

  void connectSocket() {
    if (_socket == null) {
      _initSocket();
    }
    _socket!.onConnect((data) => print('Connecting'));
    _socket!.onReconnect((data) => print('onReconnect'));
    _socket!
        .onConnectError((data) => print('Can not connect to server socket'));
    _socket!.onDisconnect((data) => print('socket disconnected'));

    _setUpServerListenerEvent();
  }

  void _setUpServerListenerEvent() async {
    Future(
      () => _socket?.on(
        'serverNotify',
        (jsonData) async {
          if (jsonData['msg'] == 'newPatient') {
            _newPatientHandle(jsonData);
          } else if (jsonData['msg'] == 'newHealthRecord') {
            _newHealthRecordHandle(jsonData);
          } else if (jsonData['msg'] == 'deleteHealthRecord') {
            _deleteHealthRecordHandle(jsonData);
          } else if (jsonData['msg'] == 'deletePatient') {
            _deletePatientHandle(jsonData);
          } else if (jsonData['msg'] == 'editHealthRecord') {
            _editHealthRecord(jsonData);
          } else if (jsonData['msg'] == 'updateHealthRecordStatus') {
            _updateStatusHealthRecordHandle(jsonData);
          } else if (jsonData['msg'] == 'newNotification') {
            _newNotificationHandle(jsonData);
          }
        },
      ),
    );
  }

  void _newNotificationHandle(jsonData) async {
    print("notification update is called");
    Future(() async {
      String newNotificationId = jsonData['notification'];
      NotificationModel? temp = await NotificationService.instance
          .getNotificationById(newNotificationId);
      if (temp != null) {
        NotificationService.instance.listNotification.add(temp);
      } else {
        print("Notification not existts");
      }
    });
  }

  void _newPatientHandle(jsonData) async {
    Future(
      () async {
        String newPatientId = jsonData['patient'];
        if (PatientService.listPatients.containsKey(newPatientId)) {
          return;
        }
        Map<String, dynamic>? patientMap =
            await PatientService.getPatientById(newPatientId);
        if (patientMap != null) {
          Patient newPatient = Patient.fromJson(patientMap);
          PatientService.listPatients.addAll({newPatient.id: newPatient});
        } else {
          print("patient not exists");
        }
      },
    );
  }

  void _deletePatientHandle(jsonData) async {
    Future(
      () {
        print('here _deletePatientHandle');
        String patientId = jsonData['patient'];
        if (PatientService.listPatients.containsKey(patientId)) {
          PatientService.listPatients.remove(patientId);
        }
      },
    );
  }

  void _newHealthRecordHandle(jsonData) async {
    Future(
      () async {
        String newHealthRecordId = jsonData['healthRecord'];
        if (HealthRecordService.listHealthRecord
            .containsKey(newHealthRecordId)) {
          print('here');
          return;
        }
        Map<String, dynamic>? healthRecordMap =
            await HealthRecordService.getHealthRecordById(newHealthRecordId);
        if (healthRecordMap != null) {
          HealthRecord newHealthRecord = HealthRecord.fromJson(healthRecordMap);
          if (PatientService.listPatients[newHealthRecord.patientId] != null) {
            HealthRecordService.listHealthRecord
                .addAll({newHealthRecordId: newHealthRecord});

            PatientService.listPatients.update(newHealthRecord.patientId,
                (value) {
              value.healthRecord ??= [];
              value.healthRecord!.add(newHealthRecordId);
              return value;
            });
          }
        } else {
          print("Health Record dose not exists");
        }
      },
    );
  }

  void _deleteHealthRecordHandle(jsonData) async {
    Future(
      () {
        print('here _deleteHealthRecordHandle');
        String removeRecordId = jsonData['id'];
        String patientId = jsonData['patientId'];
        HealthRecordService.listHealthRecord.remove(removeRecordId);
        PatientService.listPatients.update(patientId, (value) {
          if (value.healthRecord == null) {
            value.healthRecord = [] as List<String>;
          } else {
            value.healthRecord?.remove(removeRecordId);
          }
          return value;
        });
      },
    );
  }

  void _editHealthRecord(jsonData) async {
    Future(
      () async {
        print('here _editHealthRecord');
        String newHealthRecordId = jsonData['healthRecord'];
        if (!HealthRecordService.listHealthRecord
            .containsKey(newHealthRecordId)) {
          return;
        }
        Map<String, dynamic>? healthRecordMap =
            await HealthRecordService.getHealthRecordById(newHealthRecordId);
        if (healthRecordMap != null) {
          HealthRecord newHealthRecord = HealthRecord.fromJson(healthRecordMap);
          HealthRecordService.listHealthRecord.update(
            newHealthRecord.id!,
            (value) => value = newHealthRecord,
          );
          PatientService.listPatients.refresh();
        } else {
          print("Health Record dose not exists");
        }
      },
    );
  }

  void _updateStatusHealthRecordHandle(jsonData) {
    Future(
      () async {
        print('here _updateStatusHealthRecordHandle');
        String newHealthRecordId = jsonData['healthRecord'];
        String newStatus = jsonData['status'];
        if (!HealthRecordService.listHealthRecord
            .containsKey(newHealthRecordId)) {
          return;
        }
        HealthRecordService.listHealthRecord.update(
          newHealthRecordId,
          (value) {
            value.status = newStatus;
            return value;
          },
        );
      },
    );
  }

  void disconnect() {
    socket.emit(
      'disconnect socket',
      {"msg": 'disconnect'},
    );
    _socket!.disconnect();
    _socket!.destroy();
    _socket = null;
  }
}
