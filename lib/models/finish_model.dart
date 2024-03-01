import 'package:shortest_way/models/result_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'finish_model.g.dart';

@JsonSerializable()
class FinishModel {
  final String id;
  final ResultModel result;

  FinishModel({required this.id, required this.result});

  factory FinishModel.fromJson(Map<String, dynamic> json) =>
      _$FinishModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinishModelToJson(this);
}
