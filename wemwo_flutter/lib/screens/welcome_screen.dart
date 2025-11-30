import 'package:flutter/material.dart';
import '../theme/wemwo_theme.dart';
import 'login_screen.dart';
import '../widgets/wemwo_logo_text.dart';

enum _SelectedRole {
  candidate,
  employer,
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _SelectedRole? _selectedRole;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRoleSelected(_SelectedRole role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _onSubmit() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pirmiausia pasirink, kaip nori pradėti.'),
        ),
      );
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // TODO:
    // 1) Supabase / auth registracija su el. paštu ir slaptažodžiu
    // 2) Sukurti users įrašą su role = candidate / employer
    // 3) Nukreipti į atitinkamą onboardingą (kandidato arba darbdavio)

    // Pavyzdinis vietos laikinas veiksmas:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _selectedRole == _SelectedRole.candidate
              ? 'Registracija kaip kandidatas (toliau – kandidato profilis)'
              : 'Registracija kaip darbdavys (toliau – įmonės profilis)',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 420,
            minHeight: 620,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF6F2FF),
                Color(0xFFFDF1FF),
                Color(0xFFFFFFFF),
              ],
            ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const WemwoLogoText(fontSize: 28),
                  const SizedBox(height: 24),
                  const Text(
                    'Sveiki atvykę į Wemwo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: WemwoTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Darbas prasideda nuo abipusio „match“.\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: WemwoTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pasirink, kaip nori pradėti.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: WemwoTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: _ChoiceCard(
                          icon: Icons.work_outline,
                          label: 'Ieškau darbo',
                          isSelected:
                              _selectedRole == _SelectedRole.candidate,
                          onTap: () => _onRoleSelected(_SelectedRole.candidate),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ChoiceCard(
                          icon: Icons.group,
                          label: 'Ieškau žmogaus\nį komandą',
                          isSelected:
                              _selectedRole == _SelectedRole.employer,
                          onTap: () => _onRoleSelected(_SelectedRole.employer),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Registracijos forma – rodoma visada, bet logiškai susieta su role
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'El. paštas',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: WemwoTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration(
                            hintText: 'tavo@pastas.lt',
                            prefixIcon: Icons.email_outlined,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Įvesk el. paštą';
                            }
                            if (!value.contains('@')) {
                              return 'Neteisingas el. pašto formatas';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Slaptažodis',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: WemwoTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: _inputDecoration(
                            hintText: 'Bent 6 simboliai',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Įvesk slaptažodį';
                            }
                            if (value.length < 6) {
                              return 'Slaptažodis per trumpas';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Patvirtink slaptažodį',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: WemwoTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_confirmPasswordVisible,
                          decoration: _inputDecoration(
                            hintText: 'Bent 6 simboliai',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible =
                                      !_confirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pakartok slaptažodį';
                            }
                            if (value != _passwordController.text) {
                              return 'Slaptažodžiai nesutampa';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: _onSubmit,
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF6C63FF),
                                    Color(0xFFFF8AC9),
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Tęsti',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Jau turi paskyrą? ',
                        style: TextStyle(
                          fontSize: 13,
                          color: WemwoTheme.textSecondary,
                        ),
                      ),
                      _LinkText(
                        'Prisijunk',
                        onTap: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xFFF5F6FA),
      prefixIcon: Icon(prefixIcon, color: WemwoTheme.textSecondary),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF6C63FF),
          width: 1.2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? const Color(0xFF6C63FF)
        : Colors.transparent;

    final bgColor = isSelected ? Colors.white : Colors.white;

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 1.4 : 0.8,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6C63FF).withOpacity(0.08),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: const Color(0xFF6C63FF),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: WemwoTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  final String text;
  final void Function(BuildContext context)? onTap;

  const _LinkText(
    this.text, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(context) : null,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF6C63FF),
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
