import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/plant_model2.dart';

class PlantService {
  static Future<List<Plant2>> getPlants() async {
    var url =
        Uri.parse('http://cultivatech-service.azurewebsites.net/api/v1/plant');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerId = prefs.getInt('accountId');
    var userUrl = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/crops/$farmerId');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": 'Bearer $token'
    };

    final responseUser = await http.get(userUrl,
        headers: headers); // Obtener el plantId de un Farmer
    //ejmplo
    //"id": 3,
    //"farmerId": 4,
    //"plantId": 2, // Guardar plantId para mostrar en your plants

    final userPlants = jsonDecode(responseUser.body); //json de los plantId

    List<Plant2> plantsList = [];

    final response =
        await http.get(url, headers: headers); //retorna las plantas

    if (response.statusCode == 200) {
      final plants =
          jsonDecode(response.body); // retorna los json de las plantas
      for (var plant in plants) {
        if (!userPlants
            .any((userPlant) => userPlant['plantId'] == plant['id'])) {
          plantsList.add(Plant2.fromJson(plant));
        }
      }
    }
    return plantsList;
  }

  static Future<List<Plant2>> getPlantsByUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('token');
    final farmerId = prefs.getInt('accountId');

    var url = Uri.parse(
        'http://cultivatech-service.azurewebsites.net/api/v1/crops/$farmerId');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //   "Authorization": 'Bearer $token'
    };

    List<Plant2> plantsList = [];

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final plants = jsonDecode(response.body);

      for (var plant in plants) {
        final plantId = plant["plantId"];
        final plantDetailsUrl = Uri.parse(
            'http://cultivatech-service.azurewebsites.net/api/v1/plant/$plantId');
        final plantDetailsResponse =
            await http.get(plantDetailsUrl, headers: headers);

        if (plantDetailsResponse.statusCode == 200) {
          final plantDetailsJson = jsonDecode(plantDetailsResponse.body);
          Plant2 plant2 = Plant2.fromJson(plantDetailsJson);
          plantsList.add(plant2);
        }
      }
    }
    return plantsList;
  }

  static Future<void> savePlant(int plantId) async {
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

      var urlPlant = Uri.parse(
          'http://cultivatech-service.azurewebsites.net/api/v1/crops');

      var response = await http.post(urlPlant,
          headers: headers,
          body: jsonEncode(
            {'farmerId': userId, 'plantId': plantId},
          ));

      if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: $error');
    }
  }

  static Future<void> deletePlant(int plantId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('userName');

      var urlUser = Uri.parse(
          'https://agripure-mobile-service.onrender.com/api/users/username/$userName');

      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token'
      };

      final responseUser = await http.get(urlUser, headers: headers);

      final user = jsonDecode(responseUser.body);
      final userId = user['id'];

      var urlPlant = Uri.parse(
          'https://agripure-mobile-service.onrender.com/api/users/$userId/delete/$plantId');

      var response = await http.delete(
        urlPlant,
        headers: headers,
      );

      if (response.statusCode != 200) {
        return Future.error('Request error: ${response.statusCode}');
      }
    } catch (error) {
      return Future.error('Error on connectivity: ${error}');
    }
  }
}
