import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';

class CandidateProfileSetupScreen extends StatefulWidget {
  const CandidateProfileSetupScreen({super.key});

  @override
  State<CandidateProfileSetupScreen> createState() =>
      _CandidateProfileSetupScreenState();
}

class _CandidateProfileSetupScreenState
    extends State<CandidateProfileSetupScreen> {
  final _firstNameController = TextEditingController(text: 'Jonas');
  final _lastNameController = TextEditingController(text: 'Petraitis');

  String? _selectedCity;
  String? _selectedJobType;
  String? _selectedSector;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onNext() {
    // TODO: čia vėliau prijungsim validaciją + perėjimą į kitą žingsnį
    // Navigator.push(...);
  }

  @override
  Widget build(BuildContext context) {
    return WemwoScreenContainer(
      // jei tavo WemwoScreenContainer turi kitų parametrų (pvz. showBackButton),
      // čia juos pridėk
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _StepIndicator(),
              const SizedBox(height: 24),

              const WemwoLogoText(),
              const SizedBox(height: 8),
              Text(
                'Sukurk savo profilį',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 24),

              _ProfileCard(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                selectedCity: _selectedCity,
                selectedJobType: _selectedJobType,
                selectedSector: _selectedSector,
                onCityChanged: (value) =>
                    setState(() => _selectedCity = value),
                onJobTypeChanged: (value) =>
                    setState(() => _selectedJobType = value),
                onSectorChanged: (value) =>
                    setState(() => _selectedSector = value),
                onNext: _onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator();

  @override
  Widget build(BuildContext context) {
    // Paprastas 3 žingsnių indikatorius:
    // [✓ Paskyra] – [✓ Patvirtinimas] – [3 Profilis]
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepCircle(
          label: '1',
          title: 'Paskyra',
          isCompleted: true,
        ),
        _StepLine(),
        _StepCircle(
          label: '2',
          title: 'Patvirtinimas',
          isCompleted: true,
        ),
        _StepLine(),
        _StepCircle(
          label: '3',
          title: 'Profilis',
          isCurrent: true,
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  final String label;
  final String title;
  final bool isCompleted;
  final bool isCurrent;

  const _StepCircle({
    required this.label,
    required this.title,
    this.isCompleted = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isCompleted || isCurrent;

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: active
                ? const LinearGradient(
                    colors: [
                      Color(0xFF8A6CFF),
                      Color(0xFFFF72D2),
                    ],
                  )
                : null,
            border: active
                ? null
                : Border.all(
                    color: Colors.purple.shade100,
                  ),
            color: active ? null : Colors.white,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: active
                          ? Colors.white
                          : Colors.purple.shade300,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: active
                ? Colors.purple.shade400
                : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String? selectedCity;
  final String? selectedJobType;
  final String? selectedSector;
  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onJobTypeChanged;
  final ValueChanged<String?> onSectorChanged;
  final VoidCallback onNext;

  const _ProfileCard({
    required this.firstNameController,
    required this.lastNameController,
    required this.selectedCity,
    required this.selectedJobType,
    required this.selectedSector,
    required this.onCityChanged,
    required this.onJobTypeChanged,
    required this.onSectorChanged,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const _PhotoUpload(),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _TextField(
                  controller: firstNameController,
                  label: 'Vardas',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TextField(
                  controller: lastNameController,
                  label: 'Pavardė',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _Dropdown(
            label: 'Miestas',
            value: selectedCity,
            items: const [
              'Vilnius',
              'Kaunas',
              'Klaipėda',
              'Šiauliai',
              'Panevėžys',
            ],
            onChanged: onCityChanged,
            hint: 'Pasirink miestą',
          ),

          const SizedBox(height: 16),
          _Dropdown(
            label: 'Norimas darbo tipas',
            value: selectedJobType,
            items: const [
              'Pilnas etatas',
              'Nepilnas etatas',
              'Nuotolinis',
              'Hibridinis',
              'Projektinis darbas',
            ],
            onChanged: onJobTypeChanged,
            hint: 'Pasirink darbo tipą',
          ),

          const SizedBox(height: 16),
          _Dropdown(
            label: 'Sektorius',
            value: selectedSector,
            items: const [
              'IT',
              'Finansai',
              'Personalo valdymas',
              'Marketingas',
              'Gamyba',
            ],
            onChanged: onSectorChanged,
            hint: 'Pasirink sektorių',
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: WemwoButton(
              // jei pas tave parametras ne text, o label – atitinkamai pakeisk
              text: 'Toliau',
              onPressed: onNext,
              // jei turi tipą (primary / secondary) – pridėk čia
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoUpload extends StatelessWidget {
  const _PhotoUpload();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 40,
                color: Colors.purple,
              ),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF8A6CFF),
              child: const Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Įkelk profilio nuotrauką',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _TextField({
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _Dropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(hint),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
