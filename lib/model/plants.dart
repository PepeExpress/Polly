import 'dart:convert';

final String tablePlants = 'plants';

class PlantFields {
  static final List<String> values = [
    id,
    discovered,
    discoveredTime,
    name,
    description,
    urlImage,
    urlWikipedia,
    classificationResults
  ];

  static final String id = '_id';
  static final String discovered = 'discovered';
  static final String discoveredTime = 'discoveredTime';
  static final String name = 'name';
  static final String description = "description";
  static final String urlImage = 'urlImage';
  static final String urlWikipedia = 'urlWikipedia';
  static final String classificationResults = 'classificationResults';
}

class Plant {
  final int? id;
  final bool discovered;
  final DateTime discoveredTime;
  final String name;
  final String description;
  final String urlImage;
  final String urlWikipedia;
  final List<dynamic> classificationResults;

  const Plant({
    this.id,
    required this.discovered,
    required this.discoveredTime,
    required this.name,
    required this.description,
    required this.urlImage,
    required this.urlWikipedia,
    required this.classificationResults,
  });

  Map<String, Object?> toJson() => {
        PlantFields.id: id,
        PlantFields.discovered: discovered ? 1 : 0,
        PlantFields.discoveredTime: discoveredTime.toIso8601String(),
        PlantFields.name: name,
        PlantFields.description: description,
        PlantFields.urlImage: urlImage,
        PlantFields.urlWikipedia: urlWikipedia,
        PlantFields.classificationResults: jsonEncode(classificationResults),
      };

  Plant copy({
    int? id,
    bool? discovered,
    DateTime? discoveredTime,
    String? name,
    String? description,
    String? urlImage,
    String? urlWikipedia,
    List<dynamic>? classificationResults,
  }) =>
      Plant(
        id: id ?? this.id,
        discovered: discovered ?? this.discovered,
        discoveredTime: discoveredTime ?? this.discoveredTime,
        name: name ?? this.name,
        description: description ?? this.description,
        urlImage: urlImage ?? this.urlImage,
        urlWikipedia: urlWikipedia ?? this.urlWikipedia,
        classificationResults:
            classificationResults ?? this.classificationResults,
      );

  static Plant fromJson(Map<String, Object?> json) => Plant(
        id: json[PlantFields.id] as int?,
        discovered: json[PlantFields.discovered] == 1,
        discoveredTime:
            DateTime.parse(json[PlantFields.discoveredTime] as String),
        name: json[PlantFields.name] as String,
        description: json[PlantFields.description] as String,
        urlImage: json[PlantFields.urlImage] as String,
        urlWikipedia: json[PlantFields.urlWikipedia] as String,
        classificationResults:
            jsonDecode(json[PlantFields.classificationResults] as String),
      );

  String toString() {
    return this.name;
  }
}
