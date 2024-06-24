import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

class AuthService {
  static Future<void> registerFarmer(
      String email,
      String password,
      String name,
      String description,
      String imageUrl,
      String location,
      String type,
      int plantId) async {
    try {
      var url = Uri.parse(
          'http://cultivatech-service.azurewebsites.net/auth/registerFarmer');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(url,
          headers: headers,
          body: jsonEncode({
            'email': email,
            'name': name,
            'password': password,
            'description': description,
            'imageUrl': imageUrl,
            'location': location,
            'type': type,
            'planId': plantId
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value();
      } else if (response.statusCode == 400) {
        var responseBody = json.decode(response.body);
        var message = responseBody['message'];
        return Future.error('${message}');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> registerSpecialist(
      String email,
      String password,
      String name,
      String description,
      String imageUrl,
      String location,
      String type,
      int plantId,
      String expertise,
      String contactEmail,
      String areasOfFocus) async {
    try {
      var url = Uri.parse(
          'http://cultivatech-service.azurewebsites.net/auth/registerSpecialist');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(url,
          headers: headers,
          body: jsonEncode({
            'email': email,
            'name': name,
            'password': password,
            'description': description,
            'imageUrl': imageUrl,
            'location': location,
            'type': type,
            'planId': plantId,
            'expertise': expertise,
            'contactEmail': contactEmail,
            'areasOfFocus': areasOfFocus,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value();
      } else if (response.statusCode == 400) {
        var responseBody = json.decode(response.body);
        var message = responseBody['message'];
        return Future.error('${message}');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> logIn(String email, String password) async {
    try {
      var url =
          Uri.parse('http://cultivatech-service.azurewebsites.net/auth/login');
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
          {'password': password, 'email': email},
        ),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        var token = responseBody['token'];
        Map<String, dynamic> userProfile = await getProfileByEmail(email);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', userProfile['email']);
        await prefs.setString('name', userProfile['name']);
        await prefs.setString('description', userProfile['description']);
        await prefs.setInt('accountId', userProfile['accountId']);
        await prefs.setString('type', userProfile['type']);
        await prefs.setInt('planId', userProfile['planId']);
        await prefs.setString('imageUrl', userProfile['imageUrl']);
        await prefs.setString('location', userProfile['location']);
      } else if (response.statusCode == 401) {
        return Future.error('Invalid Credentials');
      } else {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: ${error}');
    }
  }

  static Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<Map<String, dynamic>> getProfileByEmail(String email) async {
    var url = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfileByEmail/$email');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error');
    }
  }

  static Future<Map<String, dynamic>> getAllNotificationsByToAccountId(
      int accountId) async {
    //Retorna las notificaciones enviadas al accountId
    var url = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/notifications/getByToAccountId/$accountId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error');
    }
  }

  static Future<List<NotificationSpecialist>> getNotifications(
      int accountId) async {
    final response = await http.get(Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/notifications/getByToAccountId/$accountId'));
    if (response.statusCode == 200) {
      final notification =
          json.decode(response.body).cast<Map<String, dynamic>>();
      return notification
          .map<NotificationSpecialist>(
              (json) => NotificationSpecialist.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  static Future<Map<String, dynamic>> getProfileByAccountId(
      int accountId) async {
    var url = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile/$accountId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error');
    }
  }
}
