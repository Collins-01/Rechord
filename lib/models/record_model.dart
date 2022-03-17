class RecordModel {
  final String path;
  final String name;
  final String date;
  RecordModel({required this.path, required this.name, required this.date});

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        path: json['path'],
        name: json['name'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'date': date,
    };
  }
}
