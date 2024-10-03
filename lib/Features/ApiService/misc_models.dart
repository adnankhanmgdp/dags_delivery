class Charges {
  final Dist dist;
  final String id;
  final List<Faq> faq;
  final String shippingPolicy;
  final String refundPolicy;
  final String privacyPolicy;
  final String tnc;
  final dynamic tax;

  Charges({
    required this.dist,
    required this.id,
    required this.faq,
    required this.shippingPolicy,
    required this.refundPolicy,
    required this.privacyPolicy,
    required this.tnc,
    required this.tax,
  });

  factory Charges.fromJson(Map<String, dynamic> json) {
    return Charges(
      dist: Dist.fromJson(json['dist']),
      id: json['_id'],
      faq: (json['faq'] as List).map((item) => Faq.fromJson(item)).toList(),
      shippingPolicy: json['shippingPolicy'],
      refundPolicy: json['refundPolicy'],
      privacyPolicy: json['privacyPolicy'],
      tnc: json['tnc'],
      tax: json['tax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dist': dist.toJson(),
      '_id': id,
      'faq': faq.map((item) => item.toJson()).toList(),
      'shippingPolicy': shippingPolicy,
      'refundPolicy': refundPolicy,
      'privacyPolicy': privacyPolicy,
      'tnc': tnc,
      'tax': tax,
    };
  }
}

class Dist {
  final dynamic five;
  final dynamic ten;
  final dynamic twenty;
  final dynamic thirty;

  Dist({
    required this.five,
    required this.ten,
    required this.twenty,
    required this.thirty,
  });

  factory Dist.fromJson(Map<String, dynamic> json) {
    return Dist(
      five: json['5'],
      ten: json['10'],
      twenty: json['20'],
      thirty: json['30'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '5': five,
      '10': ten,
      '20': twenty,
      '30': thirty,
    };
  }
}

class Faq {
  final String question;
  final String answer;
  final String id;

  Faq({
    required this.question,
    required this.answer,
    required this.id,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      question: json['question'],
      answer: json['answer'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      '_id': id,
    };
  }
}
