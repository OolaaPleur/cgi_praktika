import 'package:flutter/material.dart';
import 'package:frontend/models/aircraft.dart';
import 'package:frontend/screens/flight_details_screen/widgets/seat_selection_sheet/seat_legend_widgets.dart';
import 'package:frontend/utils/color_utils.dart';

class SeatLegendContainer extends StatelessWidget {
  final List<SeatConfiguration> configurations;
  final bool showWindowSeats;
  final bool showExtraLegroom;
  final bool showExitRow;
  final Map<String, bool> visibleClasses;
  final void Function(bool?)? onWindowSeatsChanged;
  final void Function(bool?)? onExtraLegroomChanged;
  final void Function(String, bool?)? onClassVisibilityChanged;
  final void Function(bool?)? onExitRowChanged;

  const SeatLegendContainer({
    super.key,
    required this.configurations,
    required this.showWindowSeats,
    required this.showExtraLegroom,
    required this.showExitRow,
    required this.visibleClasses,
    this.onWindowSeatsChanged,
    this.onExtraLegroomChanged,
    this.onExitRowChanged,
    this.onClassVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...configurations
                  .map(
                    (config) => SeatLegendItem(
                      color: parseColor(config.color),
                      label: config.className,
                      showCheckbox: true,
                      isChecked:
                          visibleClasses[config.className.toUpperCase()] ??
                          true,
                      onCheckChanged: (bool? value) {
                        if (onClassVisibilityChanged != null) {
                          onClassVisibilityChanged!(config.className, value);
                        }
                      },
                    ),
                  )
                  .toList(),
              const Divider(height: 32),
              SeatLegendItem(
                color: Colors.white,
                label: 'Window Seats',
                showCheckbox: true,
                isChecked: showWindowSeats,
                onCheckChanged: onWindowSeatsChanged,
                showColorSquare: false,
              ),
              SeatLegendItem(
                color: Colors.white,
                label: 'Extra Legroom',
                showCheckbox: true,
                isChecked: showExtraLegroom,
                onCheckChanged: onExtraLegroomChanged,
                showColorSquare: false,
              ),
              SeatLegendItem(
                color: Colors.white,
                label: 'Exit Row',
                showCheckbox: true,
                isChecked: showExitRow,
                onCheckChanged: onExitRowChanged,
                showColorSquare: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SeatLegendItem(color: Colors.red, label: 'Reserved'),
        SeatLegendItem(color: Colors.blue, label: 'Selected'),
      ],
    );
  }
}
