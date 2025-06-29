import 'package:flutter/material.dart';

class SortingBar extends StatelessWidget {
  final double value;
  final double width;
  final bool isTargeted;
  final bool isRunning;
  final Color color;

  const SortingBar({
    super.key,
    required this.value,
    required this.width,
    this.isTargeted = false,
    this.isRunning = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color barColor = color;
    if (isTargeted) {
      barColor = Colors.red; // Targeted color
    } else if (isRunning) {
      barColor = Colors.green; // Running color
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      width: width,
      height: value,
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)),
      ),
    );
  }
}
