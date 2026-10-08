import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const AdinnRecceApp());

class AdinnRecceApp extends StatelessWidget {
  const AdinnRecceApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Adinn Recce Measurement',
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const HomeScreen(),
      );
}
