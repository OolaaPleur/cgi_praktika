import 'dart:async';
import 'dart:convert';
import 'package:frontend/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/flight.dart';
import 'package:logging/logging.dart';

class FlightService {
  final Logger _logger = Logger('FlightService');

  Future<List<Flight>> getFlights() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.flightsEndpoint}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Flight.fromJson(json)).toList();
      } else {
        _logger.severe('Failed to load flights: ${response.statusCode}');
        throw Exception('Failed to load flights: ${response.statusCode}');
      }
    } catch (e) {
      _logger.severe('Error fetching flights', e);
      rethrow;
    }
  }

  Future<FlightDetails> getFlightDetails(int flightId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.flightsEndpoint}/$flightId',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return FlightDetails.fromJson(jsonData);
      } else {
        _logger.severe('Failed to load flight details: ${response.statusCode}');
        throw Exception(
          'Failed to load flight details: ${response.statusCode}',
        );
      }
    } catch (e) {
      _logger.severe('Error fetching flight details', e);
      rethrow;
    }
  }
}
