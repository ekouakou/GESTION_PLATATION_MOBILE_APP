import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? fillColor;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? labelStyle;
  final bool requiredIndicator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
    this.labelStyle,
    this.requiredIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final borderColor = theme.colorScheme.onBackground?.withOpacity(0.5) ?? Colors.grey;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: null, // Nous n'utilisons plus labelText directement
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: labelStyle ?? TextStyle(fontSize: 12.0, color: currentTextColor),
            children: requiredIndicator
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: currentTextColor, fontSize: 14.0),
              ),
            ]
                : [],
          ),
        ),
        filled: true,
        fillColor: fillColor ?? theme.colorScheme.background,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 0.50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 0.50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2.0),
        ),
      ),
    );
  }
}
