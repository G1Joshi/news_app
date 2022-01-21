import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static final theme = ThemeData(
    fontFamily: 'Helvetica',
    scaffoldBackgroundColor: AppColors.secondaryColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColorLight,
      foregroundColor: AppColors.secondaryColorLight,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.primaryColorLight,
    ),
  );
}
