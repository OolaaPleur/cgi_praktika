import 'package:flutter/material.dart';

/// A widget for creating legend items in the seat selection interface
class SeatLegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool showCheckbox;
  final bool isChecked;
  final void Function(bool?)? onCheckChanged;
  final bool showColorSquare;

  const SeatLegendItem({
    super.key,
    required this.color,
    required this.label,
    this.showCheckbox = false,
    this.isChecked = true,
    this.onCheckChanged,
    this.showColorSquare = true,
  });

  @override
  Widget build(BuildContext context) {
    // Format class name if it's in uppercase
    final formattedLabel =
        label.toUpperCase() == label
            ? label.substring(0, 1) + label.substring(1).toLowerCase()
            : label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showCheckbox)
            Checkbox(
              value: isChecked,
              onChanged: onCheckChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          if (showColorSquare)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black26),
              ),
            ),
          if (showColorSquare) const SizedBox(width: 8),
          Text(formattedLabel),
        ],
      ),
    );
  }
}
