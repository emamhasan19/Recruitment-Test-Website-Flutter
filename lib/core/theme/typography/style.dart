import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';
import 'package:recruitment_test_website/core/theme/typography/fonts.dart';

class AppTypography {
  static TextStyle _getTextStyle(
    double fontSize,
    String fontFamily,
    FontWeight fontWeight,
    Color color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle regular12Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold12Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s12.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular14Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold14Circular({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamilyCircular,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold14Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular16Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold16Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s16.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle semiBold18Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s18.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.semiBold,
      color ?? UIColors.black,
    );
  }

  static TextStyle bold24Caros({Color? color}) {
    return _getTextStyle(
      FontSize.s24.sp,
      FontConstants.fontFamilyCaros,
      FontWeightManager.bold,
      color ?? UIColors.black,
    );
  }

  static TextStyle regular14Circular({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamilyCircular,
      FontWeightManager.regular,
      color ?? UIColors.black,
    );
  }

  static TextStyle medium14Circular({Color? color}) {
    return _getTextStyle(
      FontSize.s14.sp,
      FontConstants.fontFamilyCircular,
      FontWeightManager.medium,
      color ?? UIColors.black,
    );
  }
}
