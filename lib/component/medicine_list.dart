class Medicine {
  Medicine({
    required this.name,
    required this.description,
    required this.type,
  });

  final String name;
  final String description;
  final String type;

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'type': type,
      };

  static Medicine fromJson(Map<String, dynamic> json) => Medicine(
        name: json['name'],
        description: json['description'],
        type: json['type'],
      );
}
