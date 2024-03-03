import 'package:flutter/material.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/coordinate_model.dart';

class CheckResultBloc {
  final CheckResultModel _checkResult;

  CheckResultBloc(this._checkResult) {
    _getCoordinates();
  }

  final List<CoordinateModel> _coordinates = [];

  void _getCoordinates() {
    List<String> pairs = _checkResult.path.split("->");
    for (final pair in pairs) {
      List<String> values =
          pair.replaceAll("(", "").replaceAll(")", "").split(",");
      for (int i = 0; i < values.length; i++) {
        _coordinates.add(
            CoordinateModel(x: int.parse(values[0]), y: int.parse(values[1])));
      }
    }
  }

  Color getColor(int index, String cell, int row, int col) {
    if (_checkResult.start.x == col && _checkResult.start.y == row) {
      return const Color(0xFF64FFDA);
    }
    if (_checkResult.end.x == col && _checkResult.end.y == row) {
      return const Color(0xFF009688);
    }

    if (cell == 'X') {
      return Colors.black;
    }

    for (int i = 0; i < _coordinates.length; i++) {
      if (i != 0 &&
          i != _coordinates.length - 1 &&
          _coordinates[i].x == col &&
          _coordinates[i].y == row) {
        return const Color(0xFF4CAF50);
      }
    }

    return Colors.white;
  }
}
