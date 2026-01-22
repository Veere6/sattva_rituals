import 'package:flutter/material.dart';
import 'info_view.dart';

class TheAshramView extends StatelessWidget {
  const TheAshramView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "The Ashram", content: "Visit our sacred Ashram in the heart of Rishikesh. A place of peace, learning, and authentic Ayurvedic practice since 1924.");
}

class SustainabilityView extends StatelessWidget {
  const SustainabilityView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Sustainability", content: "Our commitment to the Earth is as deep as our commitment to health. We use plastic-free packaging, solar-powered processing, and ethically sourced herbs.");
}
