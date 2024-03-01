import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_way/models/coordinate_model.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final String id;
  final CoordinateModel start;
  final CoordinateModel end;
  final List<String> field;

  GameModel({
    required this.id,
    required this.start,
    required this.end,
    required this.field,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);


  GameModel copyWith({
    String? id,
    CoordinateModel? start,
    CoordinateModel? end,
    List<String>? field,
  }) {
    return GameModel(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      field: field ?? this.field,
    );
  }

}
