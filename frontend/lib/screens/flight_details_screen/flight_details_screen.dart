import 'package:flutter/material.dart';
import 'package:frontend/models/flight.dart';
import 'package:frontend/screens/flight_details_screen/widgets/airport_image.dart';
import 'package:frontend/screens/flight_details_screen/widgets/info_list.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_button.dart';
import 'package:frontend/widgets/flight_information_widget.dart';

class FlightDetailsScreen extends StatelessWidget {
  final FlightDetails flight;
  final int passengerCount;

  const FlightDetailsScreen({
    super.key,
    required this.flight,
    required this.passengerCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 1100;

    return Scaffold(
      body:
          isWideScreen
              ? Row(
                children: [
                  // Left side - Flight Information
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(height: 24),
                            FlightInformationWidget(
                              departureAirport: flight.departureAirport,
                              arrivalAirport: flight.arrivalAirport,
                              price: flight.price,
                              companyName: flight.companyName,
                              companyPhotoId: flight.companyPhotoId,
                              departureDateTime: flight.departureDateTime,
                              arrivalDateTime: flight.arrivalDateTime,
                              duration: flight.duration,
                            ),
                            const SizedBox(height: 24),
                            InfoList(
                              title: 'Aircraft Information',
                              info: {
                                'Model':
                                    '${flight.aircraft.manufacturer} ${flight.aircraft.modelName}',
                                'Total Seats':
                                    flight.aircraft.totalSeats.toString(),
                              },
                            ),
                            const SizedBox(height: 32),
                            SeatSelectionButton(
                              flight: flight,
                              passengerCount: passengerCount,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right side - Aircraft Image
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: AirportImage(
                          imageUrl: flight.arrivalAirportImageUrl,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // Top - Aircraft Image
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: AirportImage(
                          imageUrl: flight.arrivalAirportImageUrl,
                          height: 300,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    // Bottom - Flight Information
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(height: 24),
                          FlightInformationWidget(
                            departureAirport: flight.departureAirport,
                            arrivalAirport: flight.arrivalAirport,
                            price: flight.price,
                            companyName: flight.companyName,
                            companyPhotoId: flight.companyPhotoId,
                            departureDateTime: flight.departureDateTime,
                            arrivalDateTime: flight.arrivalDateTime,
                            duration: flight.duration,
                          ),
                          const SizedBox(height: 24),
                          InfoList(
                            title: 'Aircraft Information',
                            info: {
                              'Model':
                                  '${flight.aircraft.manufacturer} ${flight.aircraft.modelName}',
                              'Total Seats':
                                  flight.aircraft.totalSeats.toString(),
                            },
                          ),
                          const SizedBox(height: 32),
                          SeatSelectionButton(
                            flight: flight,
                            passengerCount: passengerCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
