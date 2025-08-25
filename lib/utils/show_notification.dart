import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ShowNotification {
  static void top(
    BuildContext context,
    String message, {
    bool success = false,
  }) {
    Flushbar(
      message: message,
      backgroundColor: success ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
    ).show(context);
  }
}
