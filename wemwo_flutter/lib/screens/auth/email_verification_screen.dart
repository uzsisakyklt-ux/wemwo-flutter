import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/wemwo_logo_text.dart';
import '../../widgets/wemwo_screen_container.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final void Function(String code)? onSubmit;
  final VoidCallback? onResend;

  const EmailVerificationScreen({
    Key? key,
    required this.email,
    this.onSubmit,
    this.onResend,
  }) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController(), growable: false);
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode(), growable: false);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentCode => _controllers.map((c) => c.text).join();
  bool get _isComplete => _currentCode.length == 6;

  void _handleSubmit() {
    if (!_isComplete) return;

    final callback = widget.onSubmit;
    if (callback != null) {
      callback(_currentCode);
    } else {
      debugPrint('Entered code: $_currentCode');
    }
  }

  void _onBoxChanged(int index, String value) {
    if (value.length > 1) {
      _pasteFullCode(value);
      return;
    }

    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

  void _pasteFullCode(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < 6; i++) {
      _controllers[i].text = i < digits.length ? digits[i] : '';
    }
    setState(() {});
    if (_isComplete) {
      _focusNodes.last.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WemwoScreenContainer(
      // jei WemwoScreenContainer turi papildomų parametrų – pridėk juos čia
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                WemwoLogoText(),
                const SizedBox(height: 32),
                _buildIcon(),
                const SizedBox(height: 24),
                Text(
                  'Patvirtink savo el. paštą',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3D256B),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Išsiuntėme patvirtinimo laišką adresu:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5B32B4),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildCard(context),
                const SizedBox(height: 24),
                Text(
                  'Patvirtinimas padeda mums saugoti tavo duomenis.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color(0xFF9D6BFF),
            Color(0xFF7F4DFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x339D6BFF),
            offset: const Offset(0, 12),
            blurRadius: 24,
          ),
        ],
      ),
      child: const Icon(
        Icons.mail_outline,
        size: 38,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            offset: const Offset(0, 16),
            blurRadius: 32,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Įvesk 6 skaitmenų kodą iš laiško',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildOtpRow(),
          const SizedBox(height: 16),
          _buildResendRow(theme),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isComplete ? _handleSubmit : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: _isComplete ? 2 : 0,
              ),
              child: const Text('Patvirtinti'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return _OtpBox(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          onChanged: (value) => _onBoxChanged(index, value),
        );
      }),
    );
  }

  Widget _buildResendRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Negavai kodo? ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.black54,
          ),
        ),
        GestureDetector(
          onTap: widget.onResend,
          child: Text(
            'Siųsti dar kartą',
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF7F4DFF),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 44,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: Color(0xFFF5F2FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
