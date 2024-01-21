import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_demo/core/core.dart';

class CustomDropdownField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? helpText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final bool? isObscureText;
  final String? labelText;
  final EdgeInsets? padding;
  final List<dynamic> items;
  final String? valueSuffix;
  final dynamic value;

  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final double? width;
  final int? maxLine;
  final String? Function(Object? value)? validator;
  final void Function(dynamic)? onChange;

  const CustomDropdownField({
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
    this.valueSuffix,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: width ?? double.infinity,
        child: Padding(
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
              DropdownButtonFormField(
                items: items
                    .map((e) => DropdownMenuItem(
                        value: e, child: Text('$e $valueSuffix')))
                    .toList(),
                onChanged: onChange,
                value: value,
                style: FontUtilities.style(
                  fontSize: 16,
                  fontWeight: FWT.medium,
                  fontColor: ColorTheme.blackColor,
                ),
                validator: validator,
                padding: EdgeInsets.zero,
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  suffixIcon: suffixIcon,
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
        ),
      ),
    );
  }
}
