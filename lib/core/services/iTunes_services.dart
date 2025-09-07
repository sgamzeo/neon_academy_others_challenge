import 'dart:convert';
import 'package:dio/dio.dart';

class ITunesService {
  final Dio _dio;

  ITunesService([Dio? dio]) : _dio = dio ?? Dio();

  Future<List<Map<String, dynamic>>> searchSongs(String query) async {
    final url = 'https://itunes.apple.com/search';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'term': query, 'entity': 'song'},
      );

      final data = response.data is String
          ? json.decode(response.data)
          : response.data;

      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((e) => e is Map<String, dynamic> ? e : <String, dynamic>{})
          .toList();
    } catch (e) {
      throw Exception('Error searching songs: $e');
    }
  }
}
