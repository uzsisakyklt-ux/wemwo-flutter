import 'package:flutter/material.dart';
import 'screens/auth/email_verification_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailVerificationScreen(
        email: 'test@email.com',
      ),
    );
  }
}
