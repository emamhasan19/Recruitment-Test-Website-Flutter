import 'package:flutter/material.dart';
import 'package:recruitment_test_website/core/theme/colors.dart';

class MultipleOptionWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final String label;

  const MultipleOptionWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.purple;
                  }
                  return UIColors.platinum;
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return const BorderSide(
                      color: Colors.purple,
                    );
                  }
                  return const BorderSide(
                    color: Colors.purple,
                  );
                },
              ),
              value: value,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Colors.purple,
              checkColor: Colors.white,
              onChanged: onChanged,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: value ? FontWeight.w800 : FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
