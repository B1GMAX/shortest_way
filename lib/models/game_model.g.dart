// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String,
      start: CoordinateModel.fromJson(json['start'] as Map<String, dynamic>),
      end: CoordinateModel.fromJson(json['end'] as Map<String, dynamic>),
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'field': instance.field,
    };
