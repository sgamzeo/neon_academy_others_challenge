import 'dart:convert';
import 'package:http/http.dart' as http;

class MessageService {
  final String baseUrl;

  // constructor with default base URL
  MessageService({this.baseUrl = 'https://jsonplaceholder.typicode.com'});

  // fetch messages (GET request)
  Future<List<Map<String, String>>> fetchMessages({int limit = 10}) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      // map the JSON to List<Map<String, String>>
      return data.take(limit).map<Map<String, String>>((msg) {
        return {
          'sender': 'Barbie', // jsonPlaceholder does not have a sender field
          'message': (msg['title'] ?? '').toString(),
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch messages: ${response.statusCode}');
    }
  }

  // send a message (POST request)
  Future<bool> sendMessage(String sender, String message) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sender': sender, 'message': message}),
    );

    return response.statusCode == 201;
  }
}
