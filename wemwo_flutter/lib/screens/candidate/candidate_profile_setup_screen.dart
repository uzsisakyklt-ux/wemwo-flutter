import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';
import '../../widgets/wemwo_steps_header.dart';

import '../../models/candidate_model.dart';
import '../../stores/profile_store.dart';
import 'candidate_about_screen.dart';

class CandidateProfileSetupScreen extends StatefulWidget {
  const CandidateProfileSetupScreen({super.key});

  @override
  State<CandidateProfileSetupScreen> createState() =>
      _CandidateProfileSetupScreenState();
}

class _CandidateProfileSetupScreenState
    extends State<CandidateProfileSetupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

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
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Įrašyk savo vardą.')),
      );
      return;
    }

    if (_selectedCity == null || _selectedCity!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pasirink miestą.')),
      );
      return;
    }

    if (_selectedJobType == null || _selectedJobType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pasirink norimą darbo tipą.')),
      );
      return;
    }

    // Sukuriam / perrašom kandidatą su bazine info ir išsaugom store.
    final baseModel = CandidateModel(
      firstName: firstName,
      lastName: lastName.isNotEmpty ? lastName : null,
      city: _selectedCity,
      jobType: _selectedJobType,
      sector: _selectedSector, // 👈 sektorius iš dropdown
      // avatarUrl kol kas nenaudojam (_PhotoUpload dar tik UI)
    );

    ProfileStore.instance.save(baseModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CandidateAboutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WemwoScreenContainer(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 👉 STEP 2: Kandidato profilio kūrimas
              const WemwoStepsHeader(
                labels: ['Paskyra', 'Patvirtinimas', 'Profilis'],
                currentStep: 2,
              ),
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
              const SizedBox(height: 20),

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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const _PhotoUpload(),
          const SizedBox(height: 18),

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

          const SizedBox(height: 14),
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

          const SizedBox(height: 14),
          _Dropdown(
            label: 'Norimas darbo tipas',
            value: selectedJobType,
            items: const [
              'Iš ofiso',
              'Nuotolinis',
              'Hibridinis',
              'Bet kuris',
            ],
            onChanged: onJobTypeChanged,
            hint: 'Pasirink darbo tipą',
          ),

          const SizedBox(height: 14),
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

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: WemwoButton(
              text: 'Toliau',
              onTap: onNext,
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
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 32,
                color: Colors.purple,
              ),
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF8A6CFF),
              child: const Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Įkelk profilio nuotrauką',
          style: TextStyle(
            fontSize: 13,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.next,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          isDense: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
