import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();

  /// Light theme for the app
  static ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: lightScheme,

    iconTheme: const IconThemeData(color: Colors.orange),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return const Color.fromARGB(125, 74, 81, 117); // disabled color
            }
            return const Color.fromARGB(255, 74, 81, 117); // normal color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black; // disabled text color
            }
            return Colors.white; // normal text color
          },
        ),
        side: MaterialStateProperty.all(BorderSide.none),
        shape: MaterialStateProperty.all(const StadiumBorder()),
      ),
    ),

    /// Primary color of the app
    // primaryColor: Colors.orange,
    // primaryColorDark: Colors.orange,

    /// Styles for the app bar (top of the screen)
    // appBarTheme: const AppBarTheme(
    //   elevation: 1,
    //   backgroundColor: Colors.white,
    //   iconTheme: IconThemeData(color: Colors.black),
    //   titleTextStyle: TextStyle(
    //     color: Colors.black,
    //     fontSize: 18,
    //   ),
    // ),

    /// Styles for InputDecoration widgets
    // inputDecorationTheme: InputDecorationTheme(
    //   floatingLabelStyle: const TextStyle(
    //     color: Colors.orange,
    //   ),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: const BorderSide(
    //       color: Colors.grey,
    //       width: 2,
    //     ),
    //   ),
    //   focusColor: Colors.orange,
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: const BorderSide(
    //       color: Colors.orange,
    //       width: 2,
    //     ),
    //   ),
    // ),

    /// Styles for ElevatedButton widgets
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.orange,
    //   ),
    // ),

    /// Styles for TextButton widgets
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     foregroundColor: Colors.orange,
    //   ),
    // ),

    // iconTheme:

    /// Styles fo the font size, weight, and color to use when displaying text.
    // textTheme: _textTheme,
  );

  static ColorScheme lightScheme = const ColorScheme.light().copyWith(
    brightness: Brightness.light,
    //
    background: Colors.grey.shade100,
    // onBackground: Color(0xff000000),
    //
    primary: Colors.black,
    onPrimary: Colors.white,
    inversePrimary: Colors.grey,
    //
    secondary: Colors.orange.shade400,
    onSecondary: Colors.white,
    //
    // tertiary: Colors.white,
    // onTertiary: Colors.black,
    //
    error: Colors.red.shade700,
    // onError: Color(0xFFf5e9ed),
    //
    // surface: Color(0xFFf4f5fc),
    // onSurface: Color(0xFF0e1016),

    outline: Colors.red,
  );

  // ----------------------------------------------------------

  /// Dark theme for the app
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: darkScheme,
    // iconTheme:
    // textTheme: _textTheme,
  );

  // CHANGE THIS TO YOUR OWN COLOR SCHEME
  static ColorScheme darkScheme = const ColorScheme.dark().copyWith(
    brightness: Brightness.dark,
    //
    // background: ,
    // onBackground: ,
    //
    // primary: ,
    // onPrimary: ,
    //
    // secondary: ,
    // onSecondary: ,
    //
    // tertiary: Colors.white,
    // onTertiary: Colors.black,
    //
    // error: ,
    // onError:,
    //
    // surface: ,
    // onSurface:,
  );

  // ----------------------------------------------------------

  static TextTheme get textTheme {
    const textTheme = TextTheme();

    final bodyFont = GoogleFonts.ibmPlexSansTextTheme(textTheme);
    final headingFont = GoogleFonts.syneMonoTextTheme(textTheme);

    return bodyFont.copyWith(
      displayLarge: headingFont.displayLarge,
      displayMedium: headingFont.displayMedium,
      displaySmall: headingFont.displaySmall,
      headlineLarge: headingFont.headlineLarge,
      headlineMedium: headingFont.headlineMedium,
      headlineSmall: headingFont.headlineSmall,
      bodyLarge: bodyFont.bodyLarge,
      bodyMedium: bodyFont.bodyMedium,
      bodySmall: bodyFont.bodySmall,
    );
  }
}
