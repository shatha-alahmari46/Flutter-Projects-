class Spark {
  final String title;
  final String details;
  final String category;

  Spark({
    required this.title,
    required this.details,
    required this.category,
  });

  // Convert Spark object into a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
      'category': category,
    };
  }

  // Create a Spark object from a Map
  factory Spark.fromMap(Map<String, dynamic> map) {
    return Spark(
      title: map['title'] ?? '',
      details: map['details'] ?? '',
      category: map['category'] ?? '',
    );
  }
}