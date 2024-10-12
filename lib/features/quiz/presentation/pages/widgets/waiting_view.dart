import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({
    super.key,
    required this.size,
  });

  final ui.Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber,
              size: 72,
              color: Colors.white,
            ),
            SizedBox(height: size.height * .03),
            const Text(
              'Please grant the required permissions to start the exam.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
