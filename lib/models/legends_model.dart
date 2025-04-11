class LegendModel {
  final String title;
  final String text;
  final String wisdom;
  final String imagePath;

  LegendModel({
    required this.title,
    required this.text,
    required this.wisdom,
    required this.imagePath,
  });

  factory LegendModel.fromJson(Map<String, dynamic> json) {
    return LegendModel(
      title: json['title'] as String,
      text: json['text'] as String,
      wisdom: json['wisdom'] as String,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
      'wisdom': wisdom,
      'imagePath': imagePath,
    };
  }
}
