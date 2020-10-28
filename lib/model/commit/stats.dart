import 'package:json_annotation/json_annotation.dart';

part 'stats.g.dart';

@JsonSerializable()
class Stats {

  String id;
  int additions;
  int deletions;
  int total;

  Stats({this.id, this.additions, this.deletions, this.total});

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);
}