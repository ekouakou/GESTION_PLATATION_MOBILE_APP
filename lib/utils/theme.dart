// lib/utils/theme.dart

import 'package:flutter/material.dart';
import 'colors.dart'; // Importez votre fichier de couleurs

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColorLight,
        secondary: AppColors.secondaryColorLight,  // Remplace `accentColor` par `secondary`
        background: AppColors.backgroundColorLight, // Remplace `backgroundColor`
        error: AppColors.errorColorLight,  // Garde la gestion des erreurs
        onPrimary: AppColors.textColorLight, // Couleur du texte pour les éléments principaux
        onSecondary: AppColors.textColorLight, // Couleur du texte pour les éléments secondaires
        onBackground: AppColors.textColorLight, // Couleur du texte sur le fond
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textColorLight),  // Remplace bodyText1
        bodyMedium: TextStyle(color: AppColors.textColorLight),  // Remplace bodyText2
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColorDark,
        secondary: AppColors.secondaryColorDark,
        background: AppColors.backgroundColorDark,
        error: AppColors.errorColorDark,
        onPrimary: AppColors.textColorDark,
        onSecondary: AppColors.textColorDark,
        onBackground: AppColors.textColorDark,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textColorDark),  // Remplace bodyText1
        bodyMedium: TextStyle(color: AppColors.textColorDark),  // Remplace bodyText2
      ),
    );
  }
}
