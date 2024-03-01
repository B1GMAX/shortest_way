// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinishModel _$FinishModelFromJson(Map<String, dynamic> json) => FinishModel(
      id: json['id'] as String,
      result: ResultModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinishModelToJson(FinishModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
    };
