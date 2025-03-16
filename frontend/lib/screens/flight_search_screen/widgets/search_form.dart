import 'package:flutter/material.dart';
import 'search_text_field.dart';
import 'search_date_picker.dart';
import 'passengers_selector.dart';

class SearchForm extends StatelessWidget {
  final Set<String> airports;
  final DateTime? selectedDate;
  final int passengers;
  final Function(String) onFromChanged;
  final Function(String) onToChanged;
  final Function(DateTime?) onDateSelected;
  final Function(int) onPassengersChanged;

  const SearchForm({
    super.key,
    required this.airports,
    required this.selectedDate,
    required this.passengers,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onDateSelected,
    required this.onPassengersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth > 900;

        return Center(
          child: IntrinsicWidth(
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Flex(
                  direction: isWideScreen ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SearchTextField(
                      label: 'From',
                      icon: Icons.flight_takeoff,
                      hint: 'Enter departure city',
                      onChanged: onFromChanged,
                      suggestions: airports,
                    ),
                    const SizedBox(width: 16, height: 16),
                    SearchTextField(
                      label: 'To',
                      icon: Icons.flight_land,
                      hint: 'Enter destination city',
                      onChanged: onToChanged,
                      suggestions: airports,
                    ),
                    const SizedBox(width: 16, height: 16),
                    SearchDatePicker(
                      label: 'Departure',
                      selectedDate: selectedDate,
                      onDateSelected: onDateSelected,
                    ),
                    const SizedBox(width: 16, height: 16),
                    PassengersSelector(
                      passengers: passengers,
                      onPassengersChanged: onPassengersChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
