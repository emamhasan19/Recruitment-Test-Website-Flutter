import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';
import 'package:recruitment_test_website/core/theme/typography/style.dart';

class UnderlinedText extends StatelessWidget {
  const UnderlinedText({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 8.h,
          width: 50.w,
          color: UIColors.verdigris,
        ),
        Text(
          title,
          style: AppTypography.semiBold18Caros(
            color: UIColors.black,
          ),
        ),
      ],
    );
  }
}
