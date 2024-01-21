import 'package:flutter/material.dart';

import '../core.dart';

class CustomFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final bool isOutlined;
  const CustomFlatButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.width,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        height: 55,
        minWidth: width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isOutlined
              ? const BorderSide(color: ColorTheme.blackColor)
              : BorderSide.none,
        ),
        elevation: isOutlined ? 0 : 2,
        color: isOutlined ? ColorTheme.transparent : ColorTheme.blackColor,
        child: Text(
          title,
          style: FontUtilities.style(
            fontSize: 16,
            fontWeight: FWT.bold,
            fontColor:
                isOutlined ? ColorTheme.blackColor : ColorTheme.whiteColor,
          ),
        ),
      ),
    );
  }
}
