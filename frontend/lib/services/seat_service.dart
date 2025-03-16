import 'dart:convert';

import 'package:frontend/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class SeatService {
  final Logger _logger = Logger('SeatService');

  Future<bool> occupySeats(List<String> selectedSeats, int flightId) async {
    try {
      final requestBody = {'seatNumbers': selectedSeats};

      final response = await http.put(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.flightsEndpoint}/$flightId${ApiConstants.seatsEndpoint}',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        _logger.warning('Failed to occupy seats: ${response.statusCode}');
      }

      return response.statusCode == 200;
    } catch (e) {
      _logger.severe('Error occupying seats', e);
      return false;
    }
  }
}
