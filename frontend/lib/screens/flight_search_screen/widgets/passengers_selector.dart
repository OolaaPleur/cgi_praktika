import 'package:flutter/material.dart';

class PassengersSelector extends StatelessWidget {
  final int passengers;
  final Function(int) onPassengersChanged;

  const PassengersSelector({
    super.key,
    required this.passengers,
    required this.onPassengersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (passengers > 1) {
              onPassengersChanged(passengers - 1);
            }
          },
        ),
        Text('$passengers'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            onPassengersChanged(passengers + 1);
          },
        ),
      ],
    );
  }
}
