import 'dart:convert';

import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/api_link.dart';
import '../models/health_record.dart';
import '../models/patient.dart';
import 'auth_service/auth_service.dart';
import 'data_service/patient_service.dart';

class SocketService {
  SocketService._privateConstructor();

  static final SocketService instance = SocketService._privateConstructor();
  IO.Socket? _socket;

  IO.Socket get socket {
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
            'userType': AuthService.instance.user.type
          })
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
      () => _socket!.on(
        'serverNotify',
        (jsonData) async {
          if (jsonData['msg'] == 'newPatient') {
            _newPatientHandle(jsonData);
          } else if (jsonData['msg'] == 'newHealthRecord') {
            _newHealthRecordHandle(jsonData);
          }
        },
      ),
    );
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

  void _newHealthRecordHandle(jsonData) async {
    Future(
      () async {
        String newHealthRecordId = jsonData['healthRecord'];
        if (HealthRecordService.listHealthRecord
            .containsKey(newHealthRecordId)) {
          return;
        }
        Map<String, dynamic>? healthRecordMap =
            await HealthRecordService.getHealthRecordById(newHealthRecordId);
        if (healthRecordMap != null) {
          HealthRecord newHealthRecord = HealthRecord.fromJson(healthRecordMap);
          HealthRecordService.listHealthRecord
              .addAll({newHealthRecordId: newHealthRecord});
        } else {
          print("Health Record dose not exists");
        }
      },
    );
  }

  void disconnect() {
    socket.emit(
      'disconnect socket',
      {"msg": 'disconnect'},
    );
    _socket!.destroy();
    // _socket!.disconnect();
    _socket = null;
  }
}
