import 'dart:convert';
import 'dart:io';
import 'package:agripure_mobile/agripure/farmer/infraestructure/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String profile_url =
      'http://cultivatech-service.azurewebsites.net/api/v1/profiles/getProfile';
  final String profile_farmer_update =
      'http://cultivatech-service.azurewebsites.net/api/v1/profiles/updateFarmer';
  final String profile_specialist_update =
      'http://cultivatech-service.azurewebsites.net/api/v1/profiles/updateSpecialist';

  Future<Profile?> getData(int accountId) async {
    final response = await http.get(Uri.parse('$profile_url/$accountId'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    if (response.statusCode == HttpStatus.ok) {
      return Profile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateData(ProfileActualizarFarmer updatedProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('type') == 'FARMER') {
      final response = await http.put(
        Uri.parse('$profile_farmer_update}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(updatedProfile.toJson()),
      );
      if (response.statusCode == HttpStatus.ok) {
        // Actualización exitosa
        // Puedes mostrar una notificación o realizar cualquier otra acción deseada
      } else {
        // Error al actualizar el perfil
        throw Exception('Failed to update profile');
      }
    } else {
      final response = await http.put(
        Uri.parse('$profile_specialist_update}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(updatedProfile.toJson()),
      );
      if (response.statusCode == HttpStatus.ok) {
        // Actualización exitosa
        // Puedes mostrar una notificación o realizar cualquier otra acción deseada
      } else {
        // Error al actualizar el perfil
        throw Exception('Failed to update profile');
      }
    }
  }
}
