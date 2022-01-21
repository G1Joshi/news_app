class Sources {
  Sources({
    required this.status,
    required this.sources,
  });

  final String status;
  final List<Source> sources;

  factory Sources.fromJson(Map<String, dynamic> json) => Sources(
        status: json["status"] ?? "",
        sources: List<Source>.from(
          json["sources"].map((x) => Source.fromJson(x)),
        ),
      );
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );
}
