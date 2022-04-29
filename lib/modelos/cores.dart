import 'package:flutter/material.dart';

class Cores {
  static const MaterialColor azulEnfase = const MaterialColor(
    0xFF82B1FF,
    const <int, Color>{
      100: const Color(0xFF82B1FF),
      400: const Color(0xFF2979FF),
      700: const Color(0xFF2962FF),
    },
  );
  static const MaterialColor azul = const MaterialColor(
    0xFF2196F3,
    const <int, Color>{
      50: const Color(0xFFe3f2fd),
      100: const Color(0xFFbbdefb),
      200: const Color(0xFF90caf9),
      300: const Color(0xFF64b5f6),
      400: const Color(0xFF42a5f5),
      600: const Color(0xFF1e88e5),
      700: const Color(0xFF1976d2),
      800: const Color(0xFF1564c0),
      900: const Color(0xFFF0d47a1),
    },
  );

  static const MaterialColor vermelho = const MaterialColor(
    0xFFF44336,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );
}
