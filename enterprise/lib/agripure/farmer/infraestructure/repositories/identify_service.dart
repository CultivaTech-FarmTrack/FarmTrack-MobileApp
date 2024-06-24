import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/plant_result.dart';

class IdentifyService {
  static Future<PlantResult> sendImageToApi(String base64Image) async {
    const apiUrl = 'https://api.plant.id/v2/identify';

    final headers = {
      'Content-Type': 'application/json',
      'Api-Key': 'v2Qwwko76777JyOBlMGC5WgCHxlbmiabO3kmednr3nQ1C6eN4P',
    };

    final body = {
      'organs': ['flower', 'leaf', 'fruit'],
      'images': [base64Image],
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final suggestions = responseData['suggestions'];

        if (suggestions.isNotEmpty) {
          final plantName = suggestions[0]['plant_name'];
          final plantDetails = suggestions[0]['plant_details'];
          final probability = suggestions[0]['probability'];

          final result = PlantResult(plantName: plantName, plantDetails: plantDetails, probability: probability);
          return result;
        } else {
          throw Exception('No se encontraron sugerencias de plantas');
        }
      } else {
        throw Exception('Error en la solicitud a la API');
      }
    } catch (e) {
      throw Exception('Error al procesar la imagen: $e');
    }
  }

}