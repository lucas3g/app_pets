import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get appBar;
  TextStyle get title;
  TextStyle get body;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get appBar => GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.colors.appBar);

  @override
  TextStyle get title => GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.colors.title);

  @override
  TextStyle get body => GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppTheme.colors.body);
}
