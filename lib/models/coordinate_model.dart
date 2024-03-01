import 'package:json_annotation/json_annotation.dart';

part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel {
  final int x;
  final int y;

  CoordinateModel({
    required this.x,
    required this.y,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) => _$CoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);
}
