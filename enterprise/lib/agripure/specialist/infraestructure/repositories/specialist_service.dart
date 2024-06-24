import 'dart:convert';
import 'package:agripure_mobile/agripure/specialist/infraestructure/models/specialist_model2.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class SpecialistService {
  static Future<List<Specialist2>> getAllSpecialists() async {
    var url = Uri.parse('http://nifty-jet-404014.rj.r.appspot.com/api/v1/profiles/getSpecialists');
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": 'Bearer $token'
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final specialists = jsonDecode(response.body);
        List<Specialist2> specialistList = [];

        for (var specialist in specialists) {
          specialistList.add(Specialist2.fromJson(specialist));
        }

        return specialistList;
      } else {
        // Handle non-200 status codes
        print('Failed to fetch specialists. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle errors (e.g., print error, log it, or rethrow)
      print('Error fetching specialists: $error');
      // Return an empty list or rethrow the error, depending on your needs.
      return [];
    }
  }



}
