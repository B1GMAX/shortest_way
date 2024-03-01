import 'package:flutter/material.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/coordinate_model.dart';

class CheckResultBloc {
  final CheckResultModel checkResult;

  CheckResultBloc(this.checkResult) {
    _getCoordinates();
  }

  final List<CoordinateModel> coordinates = [];

  void _getCoordinates() {
    List<String> pairs = checkResult.path.split("->");
    for (final pair in pairs) {
      List<String> values =
          pair.replaceAll("(", "").replaceAll(")", "").split(",");
      for (int i = 0; i < values.length; i++) {
        coordinates.add(
            CoordinateModel(x: int.parse(values[0]), y: int.parse(values[1])));
      }
    }
  }

  Color getColor(int index, String cell, int row, int col) {
    Color? color;
    if (cell == '.') {
      color = Colors.white;
    } else {
      color = Colors.black;
    }

    if (checkResult.start.x == col && checkResult.start.y == row) {
      color = const Color(0xFF64FFDA);
    }
    if (checkResult.end.x == col && checkResult.end.y == row) {
      color = const Color(0xFF009688);
    }

    for (final coordinate in coordinates) {
      if (coordinate.x == col &&
          coordinate.y == row &&
          coordinate.x != checkResult.start.x &&
          coordinate.y != checkResult.start.y &&
          coordinate.x != checkResult.end.x &&
          coordinate.y != checkResult.end.y) {
        color = const Color(0xFF4CAF50);
      }
    }

    return color!;
  }
}
