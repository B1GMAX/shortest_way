import 'dart:ui';

import 'package:shortest_way/models/steps_model.dart';
import 'calculation_result.dart';
import 'game_model.dart';

class Calculations {

  CalculationResult calculatePath(
      GameModel game, VoidCallback calculateProgress) {
    final List<StepsModel> steps = [];
    steps.add(
        StepsModel(x: game.start.x.toString(), y: game.start.y.toString()));
    String path = '';
    int currentX = game.start.x;
    int currentY = game.start.y;
    path = '($currentX,$currentY)->';
    while (currentX != game.end.x || currentY != game.end.y) {
      calculateProgress();
      int nextX = currentX;
      int nextY = currentY;
      if (currentX < game.end.x) {
        nextX++;
      } else if (currentX > game.end.x) {
        nextX--;
      }
      if (currentY < game.end.y) {
        nextY++;
      } else if (currentY > game.end.y) {
        nextY--;
      }
      path += '($nextX,$nextY)->';
      currentX = nextX;
      currentY = nextY;
      steps.add(StepsModel(x: nextX.toString(), y: nextY.toString()));
    }
    path = path.substring(0, path.length - 2);
    return CalculationResult(path: path, steps: steps);
  }
}
