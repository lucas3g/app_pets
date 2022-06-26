import 'package:flutter/material.dart';
import 'dart:core';

abstract class AppColors {
  Color get appBar;
  Color get title;
  Color get body;

  MaterialColor get primary;

  final String hex = '0xff';
  final String colorFinal = '700391';
  final int hexFinal = 0;
}

class AppColorDefault implements AppColors {
  @override
  Color get appBar => Colors.black;

  @override
  Color get title => Colors.black;

  @override
  Color get body => Colors.black;

  Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  String get hex => '0xff';

  //009342 - PAPAGAIO - cf1f36 BIO //004357 Cor legal
  //246EE9 Royal Blue //FF2400 Scarlet Red //3EB489 Mint Green
  @override
  String get colorFinal => '004357';

  @override
  int get hexFinal => int.parse('$hex$colorFinal');

  @override
  MaterialColor get primary => MaterialColor(hexFinal, color);
}
