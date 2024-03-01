import 'package:json_annotation/json_annotation.dart';

part 'steps_model.g.dart';

@JsonSerializable()
class StepsModel {
  final String x;
  final String y;

  StepsModel({
    required this.x,
    required this.y,
  });

  factory StepsModel.fromJson(Map<String, dynamic> json) => _$StepsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StepsModelToJson(this);
}
