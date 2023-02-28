import 'package:flutter/material.dart';

ThemeData get light {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme(
      background: Colors.white, // main background
      onBackground: Colors.black,
      primary: Colors.indigo.shade100,
      onPrimary: Colors.black,
      brightness: Brightness.light, // app bar status
      onSecondary: Colors.black,
      onError: Colors.black,
      onSurface: Colors.black,
      surface: Colors.white, // cards
      error: Colors.red,
      secondary: Colors.indigo.shade100, // poll
    ),
    dividerColor: Colors.blueGrey[100],
  );
}

ThemeData get dark {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme(
      background: const Color.fromARGB(226, 3, 17, 58),
      onBackground: Colors.white,
      primary: Colors.blue.shade300,
      onPrimary: Colors.black,
      brightness: Brightness.dark,
      onSecondary: Colors.black,
      onError: Colors.black,
      onSurface: Colors.white,
      surface: const Color(0xff1F1F1E),
      error: Colors.red,
      secondary: Colors.indigo.shade100,
    ),
    dividerColor: Colors.white.withOpacity(0.3),
  );
}

bool get debugShowCheckedModeBanner {
  return false;
}
