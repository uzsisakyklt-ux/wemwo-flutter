// FILE: lib/screens/candidate/candidate_profile_summary_screen.dart

import 'package:flutter/material.dart';

import '../../models/candidate_model.dart';
import '../../stores/profile_store.dart';
import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_screen_container.dart';
import '../../widgets/skill_chip.dart';
import '../../widgets/salary_pill.dart';
import '../../widgets/language_chip.dart';

class CandidateProfileSummaryScreen extends StatelessWidget {
  /// Jei [model] nepaduotas, ekranas bandys užsikrauti kandidatą iš ProfileStore.
  final CandidateModel? model;

  const CandidateProfileSummaryScreen({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    // Jei model perduotas tiesiai – renderinam iškart, be future.
    if (model != null) {
      return _SummaryContent(model: model!);
    }

    // Kitu atveju – kraunam iš ProfileStore (SharedPreferences).
    return FutureBuilder<CandidateModel?>(
      future: ProfileStore.instance.load(),
      builder: (context, snapshot) {
        final m = snapshot.data;
        return _SummaryContent(model: m);
      },
    );
  }
}

class _SummaryContent extends StatelessWidget {
  final CandidateModel? model;

  const _SummaryContent({required this.model});

  @override
  Widget build(BuildContext context) {
    final m = model;

    return WemwoScreenContainer(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WemwoLogoText(),
              const SizedBox(height: 8),

              _buildHeader(context, m),
              const SizedBox(height: 14),

              // ABOUT
              if (m?.about != null && m!.about!.isNotEmpty) ...[
                const _SectionTitle(
                  title: 'Apie mane',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 6),
                Text(
                  m!.about!,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
              ],

              // SKILLS
              const _SectionTitle(title: 'Įgūdžiai', icon: Icons.bolt_outlined),
              const SizedBox(height: 8),
              if (m != null && m.skills.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: m.skills
                      .map(
                        (s) => SkillChip(
                          skill: s.name,
                          experience: s.years,
                          level: s.level,
                        ),
                      )
                      .toList(),
                )
              else
                Text(
                  'Nenurodyta',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 14),

              // SALARY
              const _SectionTitle(
                title: 'Atlyginimo lūkesčiai',
                icon: Icons.euro_outlined,
              ),
              const SizedBox(height: 8),
              if (m?.salaryFrom != null || m?.salaryTo != null)
                SalaryPill(
                  '${m?.salaryFrom ?? '-'}–${m?.salaryTo ?? '-'} € / mėn. į rankas',
                )
              else
                Text(
                  'Nenurodyta',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 14),

              // EDUCATION – meta eilutė, be didelės kortos
              const _SectionTitle(
                title: 'Išsilavinimas',
                icon: Icons.school_outlined,
              ),
              const SizedBox(height: 8),
              if (m?.education != null &&
                  ((m!.education!.degree.trim().isNotEmpty) ||
                      (m.education!.field.trim().isNotEmpty) ||
                      (m.education!.institution.trim().isNotEmpty)))
                _EducationMeta(
                  degree: m.education!.degree,
                  field: m.education!.field,
                  institution: m.education!.institution,
                )
              else
                Text(
                  'Nenurodyta',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 14),

              // LANGUAGES
              const _SectionTitle(
                title: 'Kalbos',
                icon: Icons.language_outlined,
              ),
              const SizedBox(height: 8),
              if (m != null && m.languages.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: m.languages
                      .map(
                        (l) => LanguageChip(
                          name: l.name,
                          level: l.level,
                        ),
                      )
                      .toList(),
                )
              else
                Text(
                  'Nenurodyta',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

              const SizedBox(height: 24),

              // BOTTOM BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: čia vėliau paleisim job search / discover screen.
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8A6CFF), Color(0xFFFF72D2)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: const Center(
                      child: Text(
                        'Pradėti darbo paiešką',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  /// HEADER su small gradient tags
  Widget _buildHeader(BuildContext context, CandidateModel? m) {
    final fullName = (((m?.firstName ?? '') + ' ' + (m?.lastName ?? '')).trim())
            .isNotEmpty
        ? ((m?.firstName ?? '') + ' ' + (m?.lastName ?? '')).trim()
        : 'Vardas Pavardė';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.purple.withOpacity(0.08),
          backgroundImage:
              (m?.avatarUrl != null && (m!.avatarUrl!.isNotEmpty))
                  ? NetworkImage(m.avatarUrl!)
                  : null,
          child: (m?.avatarUrl == null || m!.avatarUrl!.isEmpty)
              ? const Icon(
                  Icons.person_outline,
                  size: 32,
                  color: Color(0xFF8A6CFF),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF20202A),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  if ((m?.city ?? '').isNotEmpty)
                    _SmallPill(text: m!.city!),
                  if ((m?.jobType ?? '').isNotEmpty)
                    _SmallPill(text: m!.jobType!),
                  if ((m?.sector ?? '').isNotEmpty)
                    _SmallPill(text: m!.sector!),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EducationMeta extends StatelessWidget {
  final String degree;
  final String field;
  final String institution;

  const _EducationMeta({
    required this.degree,
    required this.field,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    final hasDegree = degree.trim().isNotEmpty;
    final hasField = field.trim().isNotEmpty;
    final hasInstitution = institution.trim().isNotEmpty;

    final metaParts = <String>[];
    if (hasDegree) metaParts.add(degree.trim());
    if (hasField) metaParts.add(field.trim());

    final meta = metaParts.join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (meta.isNotEmpty)
          Text(
            meta,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF22222A),
            ),
          ),
        if (hasInstitution) ...[
          const SizedBox(height: 2),
          Text(
            institution.trim(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF8A6CFF), Color(0xFFFF72D2)],
            ),
          ),
          child: Icon(
            icon,
            size: 13,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22222A),
          ),
        ),
      ],
    );
  }
}

class _SmallPill extends StatelessWidget {
  final String text;

  const _SmallPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8A6CFF).withOpacity(0.14),
            const Color(0xFFFF72D2).withOpacity(0.14),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF5B4AA8),
        ),
      ),
    );
  }
}
