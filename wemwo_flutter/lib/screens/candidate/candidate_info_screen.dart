import 'package:flutter/material.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_button.dart';
import '../../widgets/wemwo_screen_container.dart';
import 'candidate_about_screen.dart'; // <- svarbu: importas

class CandidateInfoScreen extends StatelessWidget {
  const CandidateInfoScreen({super.key});

  void _onContinue(BuildContext context) {
    Navigator.of(context).push(
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WemwoLogoText(),
              const SizedBox(height: 16),

              // Top icon / avatar
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF8A6CFF),
                      Color(0xFFFF72D2),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Sveiki!',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Sveikiname prisijungus prie Wemwo - modernios darbo paieškos platformos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 16),

              // 3 feature kortelės
              Row(
                children: const [
                  Expanded(
                    child: _InfoFeatureCard(
                      icon: Icons.swipe_rounded,
                      title: 'Swipe & Match',
                      text: 'Braukite į dešinę jei patinka, kairę jei ne',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8A6CFF),
                          Color(0xFF5BC0FF),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _InfoFeatureCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Pokalbiai',
                      text: 'Bendraujate tik su match\'ais',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF72D2),
                          Color(0xFFFFB86C),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _InfoFeatureCard(
                      icon: Icons.bolt_outlined,
                      title: 'Greita reakcija',
                      text: 'Atsakymai iš darbdavių per kelias minutes',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00C895),
                          Color(0xFF5BC0FF),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Checklist juostelės – kaip pavyzdyje
              const _ChecklistTile(
                icon: Icons.check_circle_rounded,
                iconColor: Color(0xFFFF72D2),
                bgColor: Color(0xFFFFF0FA),
                text: 'Braukite dešinėn jei patinka',
              ),
              const SizedBox(height: 6),
              const _ChecklistTile(
                icon: Icons.check_circle_rounded,
                iconColor: Color(0xFF5BC0FF),
                bgColor: Color(0xFFEAF5FF),
                text: 'Match\'inkitės ir pradėkite pokalbį',
              ),
              const SizedBox(height: 6),
              const _ChecklistTile(
                icon: Icons.check_circle_rounded,
                iconColor: Color(0xFF00C895),
                bgColor: Color(0xFFE6FFF7),
                text: 'Redaguokite profilį bet kada',
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: WemwoButton(
                  text: 'Pradėti Match\'inti!',
                  onTap: () => _onContinue(context),
                ),
              ),

              const SizedBox(height: 6),
              Text(
                'Turime 3+ aktyvius darbo skelbimus',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Gradient gradient;

  const _InfoFeatureCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.25,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String text;

  const _ChecklistTile({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
