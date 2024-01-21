import 'package:flutter/material.dart';

import '../core.dart';

PreferredSizeWidget customAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  bool isBackButton = true,
  VoidCallback? onBack,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppBar(
        centerTitle: true,
        leading: isBackButton
            ? GestureDetector(
                onTap: () {
                  if (onBack != null) {
                    onBack();
                  }
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorTheme.blackColor,
                  ),
                ),
              )
            : null,
        backgroundColor: ColorTheme.whiteColor,
        elevation: 0,
        title: Text(
          title,
          style: FontUtilities.style(fontSize: 18, fontWeight: FWT.semiBold),
        ),
        actions: actions != null
            ? [
                SizedBox(
                  height: 36,
                  child: Row(
                    children: actions,
                  ),
                )
              ]
            : null,
      ),
    ),
  );
}
