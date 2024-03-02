import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressWidget extends StatelessWidget {
  final bool value;

  const ProgressWidget({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                value
                    ? 'Calculating...'
                    : 'All calculations has finished, you can send your results to server',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 10.0,
              percent: value ? 0 : 1,
              progressColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
