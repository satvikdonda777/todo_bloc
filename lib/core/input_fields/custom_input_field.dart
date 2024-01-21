import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_demo/core/theme/color_theme.dart';

import '../theme/font_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final bool? isObscureText;
  final String? labelText;
  final EdgeInsets? padding;
  final String? initialValue;

  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final double? width;
  final int? maxLine;
  final String? Function(String? value)? validator;
  final Function(String? value)? onChange;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.textInputType,
    this.isObscureText,
    this.labelText,
    this.padding,
    this.onTap,
    this.inputFormatters,
    this.helpText,
    this.prefixIcon,
    this.width,
    this.maxLine,
    this.validator,
    this.onChange,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...{
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(labelText!,
                  style: FontUtilities.style(
                      fontSize: 16,
                      fontWeight: FWT.medium,
                      fontColor: ColorTheme.blackColor)),
            ),
            const SizedBox(height: 9),
          },
          SizedBox(
            width: width ?? double.infinity,
            child: TextFormField(
              inputFormatters: inputFormatters,
              style: FontUtilities.style(
                fontSize: 16,
                fontWeight: FWT.medium,
                fontColor: ColorTheme.blackColor,
              ),
              initialValue: initialValue,
              readOnly: onTap != null ? true : false,
              controller: controller,
              onTap: onTap,
              onChanged: onChange,
              maxLines: maxLine ?? 1,
              validator: validator,
              keyboardType: textInputType,
              obscureText: isObscureText ?? false,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorTheme.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorTheme.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorTheme.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorTheme.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorTheme.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
                hintText: hintText ?? '',
                hintStyle: FontUtilities.style(
                  fontSize: 16,
                  fontWeight: FWT.medium,
                  fontColor: ColorTheme.darkGrey,
                ),
                suffixIcon: suffixIcon,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
          if (helpText != null) ...{
            const SizedBox(height: 5),
            Text(helpText!,
                style: FontUtilities.style(
                  fontSize: 12,
                  fontWeight: FWT.regular,
                  fontColor: ColorTheme.red,
                )),
          }
        ],
      ),
    );
  }
}
