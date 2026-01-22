import 'package:flutter/material.dart';
import 'info_view.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Privacy Policy", content: "Your privacy is important to us. Sattva Rituals collects minimal data to process your orders and improve your experience. We never sell your personal information to third parties.");
}

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Terms of Service", content: "By using Sattva Rituals, you agree to our terms of service. Our products are authentic Ayurvedic preparations intended for wellness. Please consult a professional for specific health concerns.");
}
