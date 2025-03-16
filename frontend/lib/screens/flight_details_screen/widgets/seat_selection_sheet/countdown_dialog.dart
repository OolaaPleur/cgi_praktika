import 'package:flutter/material.dart';
import 'package:frontend/utils/countdown_controller.dart';

class CountdownDialog extends StatelessWidget {
  final String message;
  final bool isError;
  final CountdownController countdownController;

  const CountdownDialog({
    super.key,
    required this.message,
    required this.isError,
    required this.countdownController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: countdownController,
      builder: (context, _) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: isError ? Colors.red : Colors.green,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                "$message ${countdownController.secondsLeft} seconds",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
