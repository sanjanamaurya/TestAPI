class SubordinateData {
  final int id;
  final String name;
  // Add other fields as necessary

  SubordinateData({required this.id, required this.name});

  factory SubordinateData.fromJson(Map<String, dynamic> json) {
    return SubordinateData(
      id: json['id'],
      name: json['name'],

    );
  }
}
