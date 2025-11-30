// FILE: lib/screens/candidate/candidate_about_screen.dart

import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';
import '../../widgets/wemwo_steps_header.dart';

import '../../models/candidate_model.dart';
import '../../stores/profile_store.dart';
import 'candidate_profile_summary_screen.dart';

class CandidateAboutScreen extends StatefulWidget {
  const CandidateAboutScreen({super.key});

  @override
  State<CandidateAboutScreen> createState() => _CandidateAboutScreenState();
}

class _CandidateAboutScreenState extends State<CandidateAboutScreen> {
  final _aboutController = TextEditingController();

  String? _selectedSkill;
  String? _selectedSkillYears;
  String? _selectedSkillLevel;

  String? _salaryFrom;
  String? _salaryTo;

  String? _selectedLanguage;
  String? _selectedLanguageLevel;

  String? _selectedEducationLevel;
  String? _selectedEducationField;

  static const int _aboutMaxLength = 500;

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _onFinish() async {
    // 1) Apie mane negali būti tuščias
    if (_aboutController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prašau trumpai parašyti apie save.')),
      );
      return;
    }

    // 2) Konvertuojam atlyginimą
    int? _parseSalary(String? value) {
      if (value == null) return null;
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits.isEmpty) return null;
      return int.tryParse(digits);
    }

    // 3) Pasiimam esamą modelį iš 1 žingsnio (vardas, pavardė, miestas ir t.t.)
    final existing = await ProfileStore.instance.load();

    // 4) Suformuojam įgūdžius
    final skills = <Skill>[];
    if (_selectedSkill != null && _selectedSkill!.isNotEmpty) {
      final years = _selectedSkillYears ?? '';
      final level = _selectedSkillLevel;

      skills.add(
        Skill(
          name: _selectedSkill!,
          years: years.isNotEmpty ? '$years m.' : '',
          level: level,
        ),
      );
    }

    // 5) Suformuojam kalbas
    final languages = <Language>[];
    if (_selectedLanguage != null && _selectedLanguage!.isNotEmpty) {
      languages.add(
        Language(
          name: _selectedLanguage!,
          level: _selectedLanguageLevel ?? '',
        ),
      );
    }

    // 6) Suformuojam išsilavinimą
    Education? education;
    if ((_selectedEducationLevel != null &&
            _selectedEducationLevel!.isNotEmpty) ||
        (_selectedEducationField != null &&
            _selectedEducationField!.isNotEmpty)) {
      education = Education(
        degree: _selectedEducationLevel ?? '',
        field: _selectedEducationField ?? '',
        institution: '', // TODO: pridėti institucijos lauką ateityje
      );
    }

    // 7) Sukuriame galutinį modelį
    final model = CandidateModel(
      firstName: existing?.firstName,
      lastName: existing?.lastName,
      city: existing?.city,
      jobType: existing?.jobType,
      sector: existing?.sector,
      avatarUrl: existing?.avatarUrl,
      about: _aboutController.text.trim(),
      skills: skills,
      salaryFrom: _parseSalary(_salaryFrom),
      salaryTo: _parseSalary(_salaryTo),
      languages: languages,
      education: education,
    );

    // 8) Išsaugome
    await ProfileStore.instance.save(model);

    // 9) Einam į summary
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CandidateProfileSummaryScreen(model: model),
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).maybePop();
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
              /// 👉 STEP 3: Kandidato „Apie mane“
              const WemwoStepsHeader(
                labels: ['Paskyra', 'Patvirtinimas', 'Profilis'],
                currentStep: 3,
              ),
              const SizedBox(height: 16),

              const WemwoLogoText(),
              const SizedBox(height: 6),
              Text(
                'Papasakok apie save',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),

              _AboutCard(
                aboutController: _aboutController,
                aboutMaxLength: _aboutMaxLength,
                selectedSkill: _selectedSkill,
                selectedSkillYears: _selectedSkillYears,
                selectedSkillLevel: _selectedSkillLevel,
                salaryFrom: _salaryFrom,
                salaryTo: _salaryTo,
                selectedLanguage: _selectedLanguage,
                selectedLanguageLevel: _selectedLanguageLevel,
                selectedEducationLevel: _selectedEducationLevel,
                selectedEducationField: _selectedEducationField,
                onSkillChanged: (v) => setState(() => _selectedSkill = v),
                onSkillYearsChanged: (v) =>
                    setState(() => _selectedSkillYears = v),
                onSkillLevelChanged: (v) =>
                    setState(() => _selectedSkillLevel = v),
                onSalaryFromChanged: (v) =>
                    setState(() => _salaryFrom = v),
                onSalaryToChanged: (v) =>
                    setState(() => _salaryTo = v),
                onLanguageChanged: (v) =>
                    setState(() => _selectedLanguage = v),
                onLanguageLevelChanged: (v) =>
                    setState(() => _selectedLanguageLevel = v),
                onEducationLevelChanged: (v) =>
                    setState(() => _selectedEducationLevel = v),
                onEducationFieldChanged: (v) =>
                    setState(() => _selectedEducationField = v),
              ),

              const SizedBox(height: 16),

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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                        text: 'Užbaigti',
                        onTap: _onFinish,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  final TextEditingController aboutController;
  final int aboutMaxLength;

  final String? selectedSkill;
  final String? selectedSkillYears;
  final String? selectedSkillLevel;

  final String? salaryFrom;
  final String? salaryTo;

  final String? selectedLanguage;
  final String? selectedLanguageLevel;

  final String? selectedEducationLevel;
  final String? selectedEducationField;

  final ValueChanged<String?> onSkillChanged;
  final ValueChanged<String?> onSkillYearsChanged;
  final ValueChanged<String?> onSkillLevelChanged;
  final ValueChanged<String?> onSalaryFromChanged;
  final ValueChanged<String?> onSalaryToChanged;
  final ValueChanged<String?> onLanguageChanged;
  final ValueChanged<String?> onLanguageLevelChanged;
  final ValueChanged<String?> onEducationLevelChanged;
  final ValueChanged<String?> onEducationFieldChanged;

  const _AboutCard({
    required this.aboutController,
    required this.aboutMaxLength,
    required this.selectedSkill,
    required this.selectedSkillYears,
    required this.selectedSkillLevel,
    required this.salaryFrom,
    required this.salaryTo,
    required this.selectedLanguage,
    required this.selectedLanguageLevel,
    required this.selectedEducationLevel,
    required this.selectedEducationField,
    required this.onSkillChanged,
    required this.onSkillYearsChanged,
    required this.onSkillLevelChanged,
    required this.onSalaryFromChanged,
    required this.onSalaryToChanged,
    required this.onLanguageChanged,
    required this.onLanguageLevelChanged,
    required this.onEducationLevelChanged,
    required this.onEducationFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // APIE MANE
          const _SectionLabel(
            icon: Icons.person_outline,
            title: 'Apie mane',
          ),
          const SizedBox(height: 6),
          TextField(
            controller: aboutController,
            maxLines: 4,
            maxLength: aboutMaxLength,
            style: const TextStyle(fontSize: 13.5),
            decoration: InputDecoration(
              hintText:
                  'Papasakok trumpai apie save, savo patirtį ir ką ieškai...',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
              counterText: '',
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
          const SizedBox(height: 4),
          // Reaktyvus skaitiklis
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: aboutController,
            builder: (context, value, _) {
              final aboutLength = value.text.length;
              return Text(
                '$aboutLength/$aboutMaxLength simbolių',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              );
            },
          ),

          // ĮGŪDŽIAI
          const SizedBox(height: 14),
          const _SectionLabel(
            icon: Icons.bolt_outlined,
            title: 'Įgūdžiai ir patirtis',
          ),
          const SizedBox(height: 6),
          _SmallDropdown(
            hint: 'Įgūdis (pvz. React)',
            value: selectedSkill,
            items: const ['Flutter', 'React', 'Python', 'Project Management'],
            onChanged: onSkillChanged,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _SmallDropdown(
                  hint: 'Metai',
                  value: selectedSkillYears,
                  items: const ['<1', '1', '2', '3', '4', '5+'],
                  onChanged: onSkillYearsChanged,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 4,
                child: _SmallDropdown(
                  hint: 'Level',
                  value: selectedSkillLevel,
                  items: const [
                    'Intern',
                    'Junior',
                    'Mid',
                    'Senior',
                    'Lead',
                  ],
                  onChanged: onSkillLevelChanged,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 26,
                height: 26,
                child: _GradientIconButton(),
              ),
            ],
          ),

          // ATLYGINIMAS
          const SizedBox(height: 14),
          const _SectionLabel(
            icon: Icons.euro_outlined,
            title: 'Pageidaujamas atlyginimas (€ /mėn. į rankas)',
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _SmallDropdown(
                  hint: 'Nuo',
                  value: salaryFrom,
                  items: const ['800', '1000', '1500', '2000', '3000'],
                  onChanged: onSalaryFromChanged,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '—',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _SmallDropdown(
                  hint: 'Iki',
                  value: salaryTo,
                  items: const ['1000', '1500', '2000', '3000', '4000+'],
                  onChanged: onSalaryToChanged,
                ),
              ),
            ],
          ),

          // KALBOS
          const SizedBox(height: 14),
          const _SectionLabel(
            icon: Icons.language_outlined,
            title: 'Kalbos',
          ),
          const SizedBox(height: 6),
          _SmallDropdown(
            hint: 'Kalba',
            value: selectedLanguage,
            items: const ['Lietuvių', 'Anglų', 'Rusų', 'Vokiečių'],
            onChanged: onLanguageChanged,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _SmallDropdown(
                  hint: 'Lygis',
                  value: selectedLanguageLevel,
                  items: const ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
                  onChanged: onLanguageLevelChanged,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 26,
                height: 26,
                child: _GradientIconButton(),
              ),
            ],
          ),

          // IŠSILAVINIMAS
          const SizedBox(height: 14),
          const _SectionLabel(
            icon: Icons.school_outlined,
            title: 'Išsilavinimas',
          ),
          const SizedBox(height: 6),
          _SmallDropdown(
            hint: 'Lygis',
            value: selectedEducationLevel,
            items: const ['Bakalauras', 'Magistras', 'Kolegija', 'Kita'],
            onChanged: onEducationLevelChanged,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _SmallDropdown(
                  hint: 'Sritis',
                  value: selectedEducationField,
                  items: const [
                    'IT',
                    'Verslas',
                    'Psichologija',
                    'Inžinerija',
                    'Kita',
                  ],
                  onChanged: onEducationFieldChanged,
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 26,
                height: 26,
                child: _GradientIconButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? optionalText;

  const _SectionLabel({
    required this.icon,
    required this.title,
    this.optionalText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: const Color(0xFF8A6CFF),
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        if (optionalText != null) ...[
          const SizedBox(width: 4),
          Text(
            optionalText!,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ],
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
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      hint: Text(
        hint,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12.5,
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
                style: const TextStyle(fontSize: 12.5),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _GradientIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8A6CFF),
            Color(0xFFFF72D2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A6CFF).withOpacity(0.24),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.add,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
