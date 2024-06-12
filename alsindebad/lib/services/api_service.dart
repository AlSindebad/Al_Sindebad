import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.example.com';

  Future<String> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
