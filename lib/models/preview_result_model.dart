import 'coordinate_model.dart';

class PreviewResultModel {
  final List<String> field;
  final String path;
  final CoordinateModel start;
  final CoordinateModel end;

  PreviewResultModel({
    required this.field,
    required this.path,
    required this.start,
    required this.end,
  });
}
