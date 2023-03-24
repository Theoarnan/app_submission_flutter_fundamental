import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCustom {
  static const Color primaryColor = Color(0xFFFE8B00);
  static const Color secondaryColor = Color(0xFF343434);
  static const Color thirdColor = Color(0xFFD8D8D8);
  static const Color blueColor = Color(0xFF4FB6FF);
  static const Color yellowColor = Color(0xFFFAB700);
  static const Color redColor = Color.fromARGB(255, 255, 110, 74);
  static const Color darkColor = Color(0xFF082032);
  static const Color secondaryDarkColor = Color(0xFF2C394B);
  static const Color thirdDarkColor = Color(0xFF4E6E81);

  static ThemeData themeSetting() {
    return ThemeData(
      primarySwatch: Colors.orange,
      fontFamily: GoogleFonts.rubik().fontFamily,
    );
  }

  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme.copyWith(
          iconTheme: const IconThemeData(color: secondaryColor),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: secondaryColor)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: const IconThemeData(color: secondaryColor),
      textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: ThemeCustom.secondaryColor),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: secondaryDarkColor,
        indicatorColor: yellowColor,
        labelColor: primaryColor,
      ),
      listTileTheme: const ListTileThemeData(textColor: secondaryColor),
      switchTheme:
          SwitchThemeData(thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          return primaryColor;
        },
      ), trackColor: MaterialStateProperty.resolveWith(
        (states) {
          return primaryColor.withOpacity(0.5);
        },
      )),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: redColor,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkColor,
      popupMenuTheme: const PopupMenuThemeData(),
      appBarTheme: appBarTheme.copyWith(backgroundColor: darkColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.white),
      cardColor: secondaryDarkColor,
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: secondaryDarkColor,
        indicatorColor: yellowColor,
        labelColor: primaryColor,
      ),
      listTileTheme: const ListTileThemeData(textColor: Colors.white),
      switchTheme:
          SwitchThemeData(thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          return primaryColor;
        },
      ), trackColor: MaterialStateProperty.resolveWith(
        (states) {
          return primaryColor.withOpacity(0.5);
        },
      )),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        error: redColor,
      ),
    );
  }

  static AppBarTheme appBarTheme =
      const AppBarTheme(centerTitle: false, elevation: 0);
}
