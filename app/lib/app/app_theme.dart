import 'package:flutter/material.dart';
import 'package:mtw_app/map/map_card.dart';


class AppTheme {
  
  static const backgroundColor = Color.fromARGB(255, 29, 29, 29);
  static const primaryColor = Color.fromARGB(255, 233, 233, 233);
  static const onPrimaryColor = Color.fromARGB(255, 19, 13, 46);
  static const snackBarColor = primaryColor;
  static const surfaceColor = Color.fromARGB(255, 30, 30, 34);
  static const surfaceColorHighlight = Color.fromARGB(255, 41, 41, 46);
  static const textColor = Color.fromARGB(255, 238, 238, 238);
  static const iconColor = Color.fromARGB(220, 255, 255, 255);
  static const dax = 5;

  static double multiplier(int multi)
    => (dax * multi).toDouble();

  static Color onPrimaryText(bool? primary) =>
      primary != null && primary ? onPrimaryColor : textColor;

  static Color onPrimary(bool? primary) =>
      primary != null && primary ? onPrimaryColor : textColor;

  static ThemeData dark(BuildContext context) => ThemeData(
        // Basic theming
        useMaterial3: true,

        // AppBar theming
        appBarTheme: const AppBarTheme(
            // titleSpacing: 100,
            titleTextStyle: TextStyle(fontSize: 22),
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            centerTitle: true,
            actionsIconTheme: IconThemeData(color: iconColor),
            iconTheme: IconThemeData(color: iconColor)),
            
        dividerTheme: const DividerThemeData(
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: Colors.white24,
        ),

        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.white24,
          thumbColor: Colors.white
        ),

        // Colors
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          background: backgroundColor,
          surface: surfaceColor,
          surfaceTint: surfaceColor,
          surfaceVariant: surfaceColor,
          primary: primaryColor,
          
        ),

        iconButtonTheme: const IconButtonThemeData(style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          padding: MaterialStatePropertyAll(EdgeInsets.all(0))

        )),


        checkboxTheme: const CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(Colors.black),
          visualDensity: VisualDensity.compact
        ),

        // Snackbar theming
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryColor,
          contentTextStyle: TextStyle(color: onPrimaryColor),
        ),
        fontFamily: 'Open Sans',
        primaryColor: primaryColor,

        extensions: <ThemeExtension<MapCardTheme>>[
          MapCardTheme(borderRadius: multiplier(1))
        ]
        

      );
}