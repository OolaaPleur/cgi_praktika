import 'package:flutter/material.dart';

class FlightAirportsWidget extends StatelessWidget {
  final String departureAirport;
  final String arrivalAirport;
  final double? price;
  final double fontSize;
  final double priceFontSize;

  const FlightAirportsWidget({
    super.key,
    required this.departureAirport,
    required this.arrivalAirport,
    this.price,
    this.fontSize = 23,
    this.priceFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            '$departureAirport → $arrivalAirport',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (price != null)
          Text(
            '\$${price!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: priceFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            overflow: TextOverflow.visible,
          ),
      ],
    );
  }
}
