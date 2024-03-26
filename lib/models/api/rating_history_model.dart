import 'dart:convert';

List<RatingHistory> ratingHistoryFromJson(String str) =>
    (jsonDecode(str) as List)
        .map<RatingHistory>(
          (jsonData) =>
              RatingHistory.fromJson(jsonData as Map<String, dynamic>),
        )
        .toList();

String ratingHistoryToJson(List<RatingHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RatingHistory {
  String name;
  List<List<int>> points;

  RatingHistory({
    required this.name,
    required this.points,
  });

  factory RatingHistory.fromJson(Map<String, dynamic> json) {
    final pointsData = json['points'] as List<dynamic>?;

    return RatingHistory(
      name: json['name'].toString(),
      points: (pointsData != null)
          ? pointsData
              .map(
                (pointData) => (pointData as List).cast<int>(),
              )
              .toList()
          : <List<int>>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'points': List<dynamic>.from(
          points.map((x) => List<dynamic>.from(x.map((x) => x))),
        ),
      };
}
