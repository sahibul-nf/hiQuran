import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class InputText extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool obsureText;
  final TextInputType? keyboardType;
  final Function(String) onChanged;

  const InputText({
    required this.textController,
    required this.hintText,
    Key? key,
    required this.prefixIcon,
    required this.onChanged,
    this.maxLength,
    this.keyboardType,
    this.errorText,
    this.obsureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onChanged: onChanged,
      cursorColor: Theme.of(context).primaryColor,
      maxLength: maxLength,
      keyboardType: keyboardType,
      obscureText: obsureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).primaryColor,
        suffixIcon: suffixIcon,

        // prefix: icon,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: hintText,
        hintStyle: AppTextStyle.normal.copyWith(color: Colors.grey),
        errorText: errorText,
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: AppTextStyle.small.copyWith(
          color: Colors.red,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).cardColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).cardColor, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}
