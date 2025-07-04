import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/models.dart'; // Assuming ShoeModel is here

class ShoeService {
  static Future<List<ShoeModel>> fetchShoes() async {
    final response = await http.get(
      Uri.parse('https://nirmanam.com/api/ecom-products-dummy'),
    );
    print('response $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ShoeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shoes');
    }
  }
}
