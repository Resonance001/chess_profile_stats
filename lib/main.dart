import 'package:flutter/material.dart';

import 'package:chess/constants/color_schemes.g.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/models/provider/data_provider.dart';
import 'package:chess/models/provider/navigation_provider.dart';
import 'package:chess/views/home_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => DataModel()),
        ChangeNotifierProvider(create: (context) => DeviceState()),
        ChangeNotifierProvider(create: (context) => NavigationState()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: TextTheme(
          labelSmall: const TextStyle(
            fontSize: 10,
          ),
          bodySmall: GoogleFonts.merriweather(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: GoogleFonts.merriweather(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: GoogleFonts.merriweather(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
