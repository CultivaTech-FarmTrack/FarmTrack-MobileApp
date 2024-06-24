import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/devices_model.dart';

class DeviceService {
  static Future<List<DevicesCatalog>> getAllDevices() async {
    var url = Uri.parse(
        'https://my-json-server.typicode.com/DevIOT-AgriPure/agripure-jsonTres/DevicesCatalog/');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      // Mapea la lista de JSON utilizando el constructor fromJson de DevicesCatalog
      List<DevicesCatalog> devicesList = jsonData.map((deviceJson) {
        return DevicesCatalog.fromJson(deviceJson);
      }).toList();

      return devicesList;
    } else {
      throw Exception('Error al obtener la lista de dispositivos');
    }
  }

  static Future<void> saveDevice(int deviceId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final accountId = prefs.getInt('accountId');

      var urlUser = Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile/$accountId');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };

      final responseUser = await http.get(urlUser, headers: headers);

      final user = jsonDecode(
          responseUser.body); // retorna el json de la info del farmer
      final userId = user['accountId']; //captura el accountId
      //Http Request
      var urlPlant = Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/crops');

      var response = await http.post(urlPlant,
          headers: headers,
          body: jsonEncode(
            {'farmerId': userId, 'plantId': 1},
          ));

      if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }
}
