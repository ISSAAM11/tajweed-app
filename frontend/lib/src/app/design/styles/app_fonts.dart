import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

abstract final class AppFonts {
  static const nunito = TextStyle(fontFamily: "Nunito");

  static const TextStyle helvetica = TextStyle(
    fontFamily: "Helvetica",
    color: AppColors.scaffold,
  );
  static const TextStyle surahNamesFont = TextStyle(
    fontFamily: "SurahNameV4",
    color: AppColors.primaryLight,
  );
  static const TextStyle uthmanicHafsFont = TextStyle(
    fontFamily: "UthmanicHafsV18",
    color: AppColors.primaryLight,
  );

  static const TextStyle appBarTitle = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const TextStyle lato = TextStyle(
    fontFamily: "Lato",
    color: AppColors.scaffold,
  );

  static const TextStyle poppins = TextStyle(
    fontFamily: "Poppins",
    color: AppColors.scaffold,
  );
}
