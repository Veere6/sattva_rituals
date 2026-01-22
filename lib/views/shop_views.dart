import 'package:flutter/material.dart';
import 'info_view.dart';

class DigestionView extends StatelessWidget {
  const DigestionView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Digestion Rituals", content: "Explore our ancient Ayurvedic remedies for gut health and balanced digestion.");
}

class ImmunityView extends StatelessWidget {
  const ImmunityView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Immunity Boosters", content: "Strengthen your Ojas with our traditional immunity-boosting herbs and rituals.");
}

class SkinCareView extends StatelessWidget {
  const SkinCareView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Skin Care", content: "Reveal your inner glow with our handcrafted, chemical-free Ayurvedic skincare rituals.");
}

class HairRitualsView extends StatelessWidget {
  const HairRitualsView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Hair Rituals", content: "Nourish your hair from root to tip with our potent herbal oils and cleansers.");
}

class StressReliefView extends StatelessWidget {
  const StressReliefView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Stress Relief", content: "Calm your mind and soothe your nervous system with our grounding Ayurvedic practices.");
}
