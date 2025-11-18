import 'package:flutter/material.dart';
import '../theme/wemwo_theme.dart';
import 'forgot_password_screen.dart';
import '../widgets/wemwo_logo_text.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFormFilled =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: WemwoTheme.background,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420, minHeight: 620),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: WemwoTheme.backgroundGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const WemwoLogoText(fontSize: 28),
const SizedBox(height: 24),


                  const Text(
                    "Malonu matyti vėl!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: WemwoTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Prisijunk ir tęsk darbo paiešką.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: WemwoTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // El. paštas
                  TextField(
                    controller: emailController,
                    onChanged: (_) => setState(() {}),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "El. paštas",
                      hintText: "tavo@pastas.lt",
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: WemwoTheme.textSecondary,
                        fontSize: 14,
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E0E5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E0E5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF6C63FF),
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Slaptažodis
                  TextField(
                    controller: passwordController,
                    onChanged: (_) => setState(() {}),
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Slaptažodis",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: WemwoTheme.textSecondary,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E0E5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E0E5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF6C63FF),
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Pamiršai slaptažodį?
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Pamiršai slaptažodį?",
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Mygtukas
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isFormFilled ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor:
                            isFormFilled ? null : const Color(0xFFE0E0E8),
                      ).copyWith(
                        backgroundColor: isFormFilled
                            ? MaterialStateProperty.resolveWith((states) {
                                return null; // bus padengtas Ink
                              })
                            : MaterialStateProperty.all(
                                const Color(0xFFE0E0E8),
                              ),
                      ),
                      child: Ink(
                        decoration: isFormFilled
                            ? const BoxDecoration(
                                gradient: WemwoTheme.accentGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              )
                            : const BoxDecoration(
                                color: Color(0xFFE0E0E8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          child: const Text(
                            "Prisijungti",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dar neturi paskyros? ",
                        style: TextStyle(
                          color: WemwoTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Registruokis",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),
                  const Text(
                    "Saugiai saugome tavo duomenis.\nPrisijungimas užšifruotas ir saugus.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: WemwoTheme.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const _GradientText(
    this.text, {
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
