import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../specialist/infraestructure/models/contact_model.dart';
import '../models/profile_model.dart';

class ContactService {
  final String baseUrl =
      "http://cultivatech-service.azurewebsites.net/api/v1/contacts";

  Future<void> startChatContact(int id) async {
    await http.put(Uri.parse("$baseUrl/startChatForContact/$id"));
  }

  Future<List<dynamic>> getContactsForFarmer(int id) async {
    final response =
        await http.get(Uri.parse("$baseUrl/contactByFarmerId/$id"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contacts for farmer');
    }
  }

  static Future<List<Profile>> getSpecialistIdsForFarmer(int id) async {
    final response = await http.get(Uri.parse(
        "http://cultivatech-service.azurewebsites.net/api/v1/contacts/contactByFarmerId/$id"));
    if (response.statusCode == 200) {
      final notification =
          json.decode(response.body).cast<Map<String, dynamic>>();
      return notification
          .map<Profile>((json) => Profile.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load contacts for farmer');
    }
  }

  static Future<Map<String, dynamic>> getUserById(int id) async {
    var url = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error de solicitud: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error de red: $error');
    }
  }

  static Future<List<Contact>> getContactsBySpecialistId() async {
    //Guardas todos los especialistas en una lista
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final specialistId = prefs.getInt('accountId');
    final response = await http.get(
      Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/contacts/contactBySpecialistId/$specialistId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  static Future<List<Contact>> getContactsFarmerById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerId = prefs.getInt('accountId');
    final response = await http.get(
      Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/contacts/contactByFarmerId/$farmerId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  static Future<List<Profile>> getDataBySpecialistId(
      List<Contact> contacts) async {
    try {
      final List<Profile> profiles = [];

      for (var contact in contacts) {
        final response = await http.get(
          Uri.parse(
              'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile/${contact.specialistId}'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          profiles.add(Profile.fromJson(json.decode(response.body)));
        } else {
          throw Exception(
              'Failed to load profile for specialistId: ${contact.specialistId}');
        }
      }

      return profiles;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<Profile>> getDataByFarmerId(List<Contact> contacts) async {
    try {
      final List<Profile> profiles = [];

      for (var contact in contacts) {
        final response = await http.get(
          Uri.parse(
              'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile/${contact.farmerId}'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          profiles.add(Profile.fromJson(json.decode(response.body)));
        } else {
          throw Exception(
              'Failed to load profile for specialistId: ${contact.farmerId}');
        }
      }

      return profiles;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
