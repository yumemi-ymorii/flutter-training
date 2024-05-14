import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({
    required this.area,
    required this.date,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final String area;
  final DateTime date;

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
