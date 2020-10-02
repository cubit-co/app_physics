import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhysicsTheme {
  static const PRIMARY_COLOR = Color(0xff1463a6);
  static const PRIMARY_COLOR_DARK = Color(0xff2C353D);
  static const ACCENT_COLOR = Color(0xfff8d836);
  static const DANGER_COLOR = Color(0xffe36868);

  final BuildContext context;

  PhysicsTheme(this.context);

  ThemeData get themeData {
    final titleColorTextStyle = TextStyle(color: ACCENT_COLOR);

    final textTheme = Theme.of(context).textTheme.copyWith(
          headline1: titleColorTextStyle,
          headline2: titleColorTextStyle,
          headline3: titleColorTextStyle,
          headline4: titleColorTextStyle,
          headline5: titleColorTextStyle,
          headline6: titleColorTextStyle,
        );

    return ThemeData(
      primaryColor: PRIMARY_COLOR,
      primaryColorDark: PRIMARY_COLOR_DARK,
      accentColor: ACCENT_COLOR,
      errorColor: DANGER_COLOR,
      textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
        button: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      cursorColor: PRIMARY_COLOR,
      textSelectionColor: PRIMARY_COLOR.withOpacity(0.5),
      selectedRowColor: ACCENT_COLOR,
      textSelectionHandleColor: ACCENT_COLOR,
      buttonTheme: ButtonThemeData(
        buttonColor: ACCENT_COLOR,
        shape: StadiumBorder(),
        padding: EdgeInsets.all(13.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
        errorStyle: TextStyle(height: 0.8, color: DANGER_COLOR),
      ),
    );
  }
}
