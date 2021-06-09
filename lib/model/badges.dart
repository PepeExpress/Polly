final String tableBadges = 'badges';

class BadgeFields {
  static final List<String> values = [
    id,
    discovered,
    discoveredTime,
    name,
    description,
    imagePath,
  ];

  static final String id = '_id';
  static final String discovered = 'discovered';
  static final String discoveredTime = 'discoveredTime';
  static final String name = 'name';
  static final String description = "description";
  static final String imagePath = 'imagePath';
}

class Badge {
  final int? id;
  final bool discovered;
  final DateTime discoveredTime;
  final String name;
  final String description;
  final String imagePath;

  const Badge({
    this.id,
    required this.discovered,
    required this.discoveredTime,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  Map<String, Object?> toJson() => {
        BadgeFields.id: id,
        BadgeFields.discovered: discovered ? 1 : 0,
        BadgeFields.discoveredTime: discoveredTime.toIso8601String(),
        BadgeFields.name: name,
        BadgeFields.description: description,
        BadgeFields.imagePath: imagePath,
      };

  Badge copy({
    int? id,
    bool? discovered,
    DateTime? discoveredTime,
    String? name,
    String? description,
    String? imagePath,
  }) =>
      Badge(
        id: id ?? this.id,
        discovered: discovered ?? this.discovered,
        discoveredTime: discoveredTime ?? this.discoveredTime,
        name: name ?? this.name,
        description: description ?? this.description,
        imagePath: imagePath ?? this.imagePath,
      );

  static Badge fromJson(Map<String, Object?> json) => Badge(
        id: json[BadgeFields.id] as int?,
        discovered: json[BadgeFields.discovered] == 1,
        discoveredTime:
            DateTime.parse(json[BadgeFields.discoveredTime] as String),
        name: json[BadgeFields.name] as String,
        description: json[BadgeFields.description] as String,
        imagePath: json[BadgeFields.imagePath] as String,
      );

  String toString() {
    return this.name;
  }
}
