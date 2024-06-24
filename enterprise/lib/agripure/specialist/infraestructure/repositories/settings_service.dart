import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static Future<bool> changeEmail(String newEmail) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final String? userName = prefs.getString('userName');

      var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/users/username/$userName');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',
      };

      final responseUser = await http.get(url, headers: headers);

      final user = jsonDecode(responseUser.body);
      final name = user['name'];

      Map<String, String> body = {
        "email": newEmail,
        "name": name,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Email cambiado exitosamente
        return true;
      } else {
        // Error al cambiar el email
        return false;
      }
    } catch (error) {
      // Error de conectividad u otro error
      return false;
    }
  }

  static Future<bool> changePassword(String currentPassword, String newPassword) async {
    var url = Uri.parse('https://agripure-mobile-service.onrender.com/api/change-password');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String? userName = prefs.getString('userName');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };

    Map<String, String> body = {
      "newPassword": newPassword,
      "oldPassword": currentPassword,
      "username": '$userName'
    };

    final response = await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Cambio de contraseña exitoso
      return true;
    } else {
      // Error al cambiar la contraseña
      return false;
    }
  }
}