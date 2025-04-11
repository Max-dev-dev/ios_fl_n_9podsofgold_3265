class LuckPrinciple {
  final String title;
  final String description;
  final String tip;

  LuckPrinciple({
    required this.title,
    required this.description,
    required this.tip,
  });

  factory LuckPrinciple.fromMap(Map<String, String> map) {
    return LuckPrinciple(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      tip: map['tip'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'title': title,
      'description': description,
      'tip': tip,
    };
  }
}

class CustomPrinciple {
  final LuckPrinciple principle;
  final String userDescription;

  CustomPrinciple({required this.principle, required this.userDescription});

  Map<String, dynamic> toJson() => {
    'title': principle.title,
    'description': principle.description,
    'tip': principle.tip,
    'userDescription': userDescription,
  };

  factory CustomPrinciple.fromJson(Map<String, dynamic> json) {
    return CustomPrinciple(
      principle: LuckPrinciple(
        title: json['title'],
        description: json['description'],
        tip: json['tip'],
      ),
      userDescription: json['userDescription'],
    );
  }
}

