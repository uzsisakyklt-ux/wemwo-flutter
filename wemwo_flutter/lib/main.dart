import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WemwoApp());
}

class WemwoApp extends StatelessWidget {
  const WemwoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wemwo',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),  // su const
    );
  }
}
