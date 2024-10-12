import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';

class Avatar extends StatelessWidget {
  const Avatar.circle({
    required this.url,
    super.key,
    this.backgroundColor = UIColors.pineGreen,
    this.borderColor = UIColors.white,
    this.activityStatus,
    this.onTap,
    this.height = 128,
    this.width = 128,
    this.border = 0,
    this.activityIconBottomPosition = 8,
    this.activityIconRightPosition = 8,
    this.child,
    this.fontSize = 14,
    this.name = '',
  });

  factory Avatar.circleWithFullName({
    required String nameWithLetter,
    Key? key,
    Color? backgroundColor,
    Color? borderColor,
    bool? activityStatus,
    VoidCallback? onTap,
    double height = 128,
    double width = 128,
    double border = 0,
    double activityIconBottomPosition = 8,
    double activityIconRightPosition = 8,
    Widget? child,
    double? fontSize = 16,
  }) {
    return Avatar.circle(
      url: '',
      key: key,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      activityStatus: activityStatus,
      onTap: onTap,
      height: height,
      width: width,
      border: border,
      activityIconBottomPosition: activityIconBottomPosition,
      activityIconRightPosition: activityIconRightPosition,
      fontSize: fontSize,
      name: nameWithLetter,
      child: child,
    );
  }

  final String url;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? activityStatus;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double border;
  final double activityIconBottomPosition;
  final double activityIconRightPosition;
  final Widget? child;
  final double? fontSize;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final nameWithLetter = name!.isNotEmpty ? name : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.h,
        height: height.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(
            color: borderColor!,
            width: border.h,
          ),
          image: url.isNotEmpty
              ? DecorationImage(
                  image: url.startsWith('/9j/')
                      ? MemoryImage(
                          Uint8List.fromList(
                            base64.decode(url),
                          ),
                        ) as ImageProvider
                      : NetworkImage(
                          url,
                        ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: nameWithLetter!.isNotEmpty
            ? Center(
                child: Text(
                  nameWithLetter,
                  style: TextStyle(
                    color: UIColors.pineGreen,
                    fontSize: fontSize,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
