import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';
import '../../widgets/wemwo_steps_header.dart'; // 👈 naujas import
import 'employer_about_screen.dart';

class EmployerProfileSetupScreen extends StatefulWidget {
  const EmployerProfileSetupScreen({super.key});

  @override
  State<EmployerProfileSetupScreen> createState() =>
      _EmployerProfileSetupScreenState();
}

class _EmployerProfileSetupScreenState
    extends State<EmployerProfileSetupScreen> {
  final _companyNameController = TextEditingController(text: 'UAB Wemwo');
  String? _selectedCity;
  String? _selectedIndustry;

  @override
  void dispose() {
    _companyNameController.dispose();
    super.dispose();
  }

  void _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EmployerAboutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WemwoScreenContainer(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 👉 STEP 2: Profilio sukūrimas
              const WemwoStepsHeader(
                labels: ['Paskyra', 'Patvirtinimas', 'Profilis'],
                currentStep: 2,
              ),
              const SizedBox(height: 18),

              /// Wemwo logo
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
                'Pagrindinė informacija apie įmonę',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 18),

              _LogoUploader(),
              const SizedBox(height: 6),
              Text(
                'Rekomenduojamas dydis: 500x500px',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),

              const SizedBox(height: 20),

              _FieldLabel('Įmonės pavadinimas'),
              const SizedBox(height: 6),
              TextField(
                controller: _companyNameController,
                readOnly: true,
                style: const TextStyle(fontSize: 13.5),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              _FieldLabel('Miestas'),
              const SizedBox(height: 6),
              _SmallDropdown(
                hint: 'Pasirinkite miestą',
                value: _selectedCity,
                items: const [
                  'Vilnius',
                  'Kaunas',
                  'Klaipėda',
                  'Šiauliai',
                  'Panevėžys',
                  'Kita',
                ],
                onChanged: (v) => setState(() => _selectedCity = v),
              ),

              const SizedBox(height: 14),

              _FieldLabel('Pramonės šaka'),
              const SizedBox(height: 6),
              _SmallDropdown(
                hint: 'Pasirinkite pramonės šaką',
                value: _selectedIndustry,
                items: const [
                  'IT ir technologijos',
                  'Finansai',
                  'Gamyba',
                  'Prekyba',
                  'Paslaugos',
                  'Kita',
                ],
                onChanged: (v) => setState(() => _selectedIndustry = v),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: WemwoButton(
                  text: 'Tęsti',
                  onTap: _onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Logo įkėlimo UI
class _LogoUploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        // TODO: atidaryti image picker
      },
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.photo_camera_outlined,
                size: 26,
                color: Colors.grey.shade500,
              ),
              const SizedBox(height: 6),
              Text(
                'Įkelti logo',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}

class _SmallDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _SmallDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      menuMaxHeight: 260,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(
        hint,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade500,
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
