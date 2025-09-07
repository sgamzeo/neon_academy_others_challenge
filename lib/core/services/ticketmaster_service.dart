import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neon_others_challenge/core/api_constants.dart';
import 'package:neon_others_challenge/core/secrets/api_key.dart';

class TicketmasterService {
  Future<List<Map<String, dynamic>>> fetchEvents({
    String? keyword,
    String? countryCode,
    String? classificationName,
    String? source,
    String? attractionId,
    String? dmaId,
  }) async {
    final queryParams = [
      if (keyword != null) "keyword=$keyword",
      if (countryCode != null) "countryCode=$countryCode",
      if (classificationName != null) "classificationName=$classificationName",
      if (source != null) "source=$source",
      if (attractionId != null) "attractionId=$attractionId",
      if (dmaId != null) "dmaId=$dmaId",
      "apikey=$TICKETMASTER_CONSUMER_KEY",
    ].join("&");

    final url = Uri.parse("$TICKETMASTER_BASE_URL?$queryParams");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final events = data['_embedded']?['events'] as List<dynamic>?;
      return events?.map((e) => e as Map<String, dynamic>).toList() ?? [];
    } else {
      throw Exception("Failed to fetch events: ${response.statusCode}");
    }
  }
}
