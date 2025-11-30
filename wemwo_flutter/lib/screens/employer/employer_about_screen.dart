import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';
import '../../widgets/wemwo_steps_header.dart';
import 'employer_info_screen.dart';

class EmployerAboutScreen extends StatefulWidget {
  const EmployerAboutScreen({super.key});

  @override
  State<EmployerAboutScreen> createState() => _EmployerAboutScreenState();
}

class _EmployerAboutScreenState extends State<EmployerAboutScreen> {
  final _aboutController = TextEditingController();
  static const int _aboutMaxLength = 500;

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  void _onBack() {
    Navigator.of(context).maybePop();
  }

  void _onFinish() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const EmployerInfoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aboutLength = _aboutController.text.length;

    return WemwoScreenContainer(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 👉 STEP 3: About ekranas
              const WemwoStepsHeader(
                labels: ['Paskyra', 'Patvirtinimas', 'Profilis'],
                currentStep: 3,
              ),
              const SizedBox(height: 18),

              const WemwoLogoText(),
              const SizedBox(height: 18),

              Text(
                'Įmonės profilis',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Aprašykite savo įmonę',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Įmonės aprašymas',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '(neprivaloma)',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _aboutController,
                      maxLines: 6,
                      maxLength: _aboutMaxLength,
                      style: const TextStyle(fontSize: 13.5),
                      decoration: InputDecoration(
                        hintText:
                            'Papasakokite apie savo įmonę, vertybes, komandą ir tai, ko ieškote naujuose darbuotojuose...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                        counterText: '',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$aboutLength / $_aboutMaxLength',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: _onBack,
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Atgal',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: WemwoButton(
                              text: 'Baigti',
                              onTap: _onFinish,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // čia be const _PageDot, nes viduje naudojami ne-const spalvų šešėliai
                  _PageDot(isActive: false),
                  SizedBox(width: 6),
                  _PageDot(isActive: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageDot extends StatelessWidget {
  final bool isActive;

  const _PageDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 9 : 7,
      height: isActive ? 9 : 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xFF8A6CFF)
            : Colors.grey.shade300.withOpacity(0.9),
      ),
    );
  }
}
