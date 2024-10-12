// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';

class ShowSnackBarMessage {
  static void showSuccessSnackBar({
    required String message,
    required BuildContext context,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: UIColors.white, fontSize: 16),
          ),
        ),
        backgroundColor: UIColors.pineGreen,
      ),
    );
  }

  static void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: UIColors.white, fontSize: 16),
          ),
        ),
        backgroundColor: UIColors.red,
      ),
    );
  }

  static void showLoadingSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Center(
              child: Text(
                message,
                style: const TextStyle(color: UIColors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: UIColors.pineGreen,
      ),
    );
  }
}
