import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recruitment_test_website/core/theme/theme.dart';
import 'package:recruitment_test_website/core/theme/typography/style.dart';
import 'package:recruitment_test_website/core/utils/assets.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<ModalCard> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet<void>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(24).copyWith(
                right: 0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _ModalHeader(title: title),
                  ...children,
                ],
              ),
            );
          },
        );
      },
      child: Image.asset(
        Assets.expandIcon,
        width: 24.sp,
        height: 24.sp,
      ),
    );
  }
}

class ModalCard extends StatelessWidget {
  const ModalCard({
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  final VoidCallback? onTap;
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 64.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: UIColors.antiFlashWhite,
                child: Image.asset(icon),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 49,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFF5F6F6),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppTypography.bold14Caros(
                            color: UIColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              Assets.remove,
              width: 24.sp,
              height: 24.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTypography.bold14Caros(
                    color: UIColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
