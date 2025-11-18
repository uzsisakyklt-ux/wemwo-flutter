import 'package:flutter/material.dart';
import '../theme/wemwo_theme.dart';
import '../widgets/wemwo_screen_container.dart';
import '../widgets/wemwo_logo_text.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFilled = emailController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: WemwoTheme.background,
      body: WemwoScreenContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔙 Atgal
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text("Atgal"),
                style: TextButton.styleFrom(
                  foregroundColor: WemwoTheme.textSecondary,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Wemwo
            const WemwoLogoText(fontSize: 28),
const SizedBox(height: 24),
            const Text(
              "Pamiršai slaptažodį?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: WemwoTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Nieko tokio! Įvesk savo el. paštą ir atsiųsime\n"
              "tau atkūrimo nuorodą.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: WemwoTheme.textSecondary,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 40),

            // El. paštas
            TextField(
              controller: emailController,
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "El. paštas",
                hintText: "tavo@pastas.lt",
                prefixIcon: const Icon(Icons.mail_outline),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Mygtukas
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFilled
                    ? () {
                        // čia vėliau darysim tikrą logiką
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Atkūrimo nuoroda išsiųsta ✉"),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text("Siųsti atkūrimo nuorodą"),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Nuoroda bus galiojanti 1 valandą.\n"
              "Jei turi problemų, susisiek su mumis.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: WemwoTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
