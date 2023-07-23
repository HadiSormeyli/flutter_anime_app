import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

push(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

pop(BuildContext context) {
  Navigator.pop(context);
}

convertToTime(int seconds) {
  int minutes = (seconds / 60).floor();
  int remainingSeconds = seconds % 60;

  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

String formatNumber(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    final double value = number / 1000;
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}k';
  } else {
    final double value = number / 1000000;
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M';
  }
}