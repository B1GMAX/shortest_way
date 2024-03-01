import 'coordinate_model.dart';

class CheckResultModel {
  final List<String> field;
  final String path;
  final CoordinateModel start;
  final CoordinateModel end;

  CheckResultModel({
    required this.field,
    required this.path,
    required this.start,
    required this.end,
  });
}
