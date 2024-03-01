import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_way/models/steps_model.dart';


part 'result_model.g.dart';

@JsonSerializable()
class ResultModel {
  final List<StepsModel> steps;
  final String path;

  ResultModel({required this.path, required this.steps});

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}
