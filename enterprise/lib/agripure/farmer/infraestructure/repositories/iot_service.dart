import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/iot_model.dart';

class IoTService {
  static Future<List<IoTDevice>> getDeviceByFarmerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerId = prefs.getInt('accountId');
    final response = await http.get(
      Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/devices/getDevicesByFarmerId/$farmerId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => IoTDevice.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  static Future<List<IoTDeviceInformation>> getInformationByDeviceId() async {
    try {
      final List<IoTDeviceInformation> deviceInformationList = [];
      final List<IoTDevice> devices = await getDeviceByFarmerId();

      for (var device in devices) {
        final response = await http.get(
          Uri.parse(
              'http://cultivatech-service.azurewebsites.net/api/v1/devices/temperaturehumidity/${device.id}'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final IoTDeviceInformation deviceInformation =
              IoTDeviceInformation.fromJson(json.decode(response.body));
          deviceInformationList.add(deviceInformation);
        } else {
          throw Exception(
              'Failed to load profile for specialistId: ${device.id}');
        }
      }

      return deviceInformationList;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
