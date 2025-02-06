import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart'; // Assurez-vous d'importer les couleurs

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool requiredIndicator;
  final int initialYear;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.requiredIndicator = false,
    this.initialYear = 1900,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    // Sélectionner les couleurs en fonction du mode de thème
    final textColor = brightness == Brightness.light
        ? AppColors.textColorLight
        : AppColors.textColorDark;
    final borderColor = brightness == Brightness.light
        ? AppColors.secondaryColorLight.withOpacity(0.5)
        : AppColors.secondaryColorDark.withOpacity(0.5);
    final focusedBorderColor = brightness == Brightness.light
        ? AppColors.accentColorLight
        : AppColors.accentColorDark;
    final errorColor = brightness == Brightness.light
        ? AppColors.errorColorLight
        : AppColors.errorColorDark;

    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: null,
        label: RichText(
          text: TextSpan(
            text: widget.labelText,
            style: TextStyle(fontSize: 12.0, color: textColor),
            children: widget.requiredIndicator
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: textColor, fontSize: 14.0),
              ),
            ]
                : [],
          ),
        ),
        prefixIcon: Icon(
          Icons.calendar_today,
          size: 20.0,
          color: theme.iconTheme.color ?? Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 0.50),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: errorColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 0.50),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(widget.initialYear),
          lastDate: DateTime(2101),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: focusedBorderColor,
                colorScheme: ColorScheme.light(
                  primary: focusedBorderColor,
                  onSurface: textColor,
                ),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          setState(() {
            widget.controller.text = formattedDate;
          });
        }
      },
    );
  }
}
