class FooterLink {
  final String title;
  final List<String> items;

  FooterLink({required this.title, required this.items});
}

class FooterData {
  static final List<FooterLink> shopLinks = [
    FooterLink(title: "SHOP", items: ["Digestion", "Immunity", "Skin Care", "Hair Rituals", "Stress Relief"]),
  ];

  static final List<FooterLink> resourceLinks = [
    FooterLink(title: "RESOURCES", items: ["Our Story", "The Ashram", "Ayurveda 101", "Journal", "Sustainability"]),
  ];

  static final List<FooterLink> supportLinks = [
    FooterLink(title: "SUPPORT", items: ["Contact Us", "Track Order", "Shipping", "Returns", "Wholesale"]),
  ];

  static const String address = "123 Wisdom Valley, Rishikesh, Uttarakhand, India";
  static const String phone = "+91 9131087223";
  static const String email = "info@sattvarituals.com";
}
