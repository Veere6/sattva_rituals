import 'package:flutter/material.dart';
import 'info_view.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Contact Us", content: "Reach out to us at info@sattvarituals.com or call us at +91 9131087223. Our Ashram is open for visitors from 9 AM to 5 PM.");
}

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Track Order", content: "Your order is being prepared with care. Please check your email for the tracking ID to follow its journey from our Ashram to your home.");
}

class ShippingView extends StatelessWidget {
  const ShippingView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Shipping Info", content: "We ship our Ayurvedic rituals worldwide. Domestic shipping takes 3-5 days, while international orders arrive within 10-14 days.");
}

class ReturnsView extends StatelessWidget {
  const ReturnsView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Returns & Exchanges", content: "Due to the nature of our products, we only accept returns for damaged items. Please contact us within 24 hours of delivery.");
}

class WholesaleView extends StatelessWidget {
  const WholesaleView({super.key});
  @override
  Widget build(BuildContext context) => const InfoView(title: "Wholesale Inquiry", content: "Partner with Sattva Rituals to bring ancient wisdom to your store. Contact our wholesale team for bulk pricing and partnership opportunities.");
}
