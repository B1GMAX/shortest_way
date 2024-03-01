// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameResultModel _$GameResultModelFromJson(Map<String, dynamic> json) =>
    GameResultModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      gameModel: (json['data'] as List<dynamic>)
          .map((e) => GameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameResultModelToJson(GameResultModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.gameModel,
    };
