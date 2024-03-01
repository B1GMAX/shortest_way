import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_way/models/game_model.dart';

part 'game_result_model.g.dart';

@JsonSerializable()
class GameResultModel{
  final bool error;
  final String message;
  @JsonKey(name: 'data')final List<GameModel> gameModel;

  GameResultModel({
    required this.error,
    required this.message,
    required this.gameModel,
  });

  factory GameResultModel.fromJson(Map<String, dynamic> json) => _$GameResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameResultModelToJson(this);
}