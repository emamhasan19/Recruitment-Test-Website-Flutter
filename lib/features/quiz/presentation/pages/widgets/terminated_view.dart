import 'package:flutter/material.dart';
import 'package:recruitment_test_website/core/services/routes/routes.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';

class TerminatedView extends StatelessWidget {
  const TerminatedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.stop_screen_share_outlined,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Sorry! your exam was terminated due to one of the following reasons:',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '- Attempt to change tabs or navigate away from the exam.\n'
              '- Stop screen sharing during the exam.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.recruitment,
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: UIColors.purple,
                backgroundColor: UIColors.white,
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.15,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
