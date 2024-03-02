import 'package:shortest_way/models/steps_model.dart';

class CalculationResult{
  final String path;
  final List<StepsModel> steps;

  CalculationResult({required this.path, required this.steps});
}