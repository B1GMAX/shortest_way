import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/calculations/calculations.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/finish_model.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';
import 'package:shortest_way/models/result_model.dart';

class ProcessBloc {
  final List<GameModel> _gameModelList;

  final List<FinishModel> _finishModelList = [];

  final Repository _repository = Repository();

  final _progressController = BehaviorSubject<double>();

  final _checkResultModelListController =
      BehaviorSubject<List<CheckResultModel>>();

  final _sendDataCheckController = BehaviorSubject<bool>();

  final _processResultController = BehaviorSubject<ProcessResultModel>();

  Stream<bool> get sendDataCheckStream => _sendDataCheckController.stream;

  Stream<ProcessResultModel> get processResultStream =>
      _processResultController.stream;

  Stream<double> get progressStream => _progressController.stream;

  Stream<List<CheckResultModel>> get checkResulModelListStream =>
      _checkResultModelListController.stream;

  ProcessBloc(this._gameModelList) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _findPath());
  }

  final Calculations _calculations = Calculations();

  Future<double> _calculateTotalSteps() async {
    double totalSteps = 0;
    for (final game in _gameModelList) {
      final calculationResult =
          await _calculations.calculatePath(game, () async {});
      totalSteps += calculationResult.steps.length;
    }
    return totalSteps;
  }

  void _findPath() async {
    final List<CheckResultModel> checkResultModelList = [];
    final double totalSteps = await _calculateTotalSteps();
    int currentStep = 0;
    for (final game in _gameModelList) {
      final calculationResult =
          await _calculations.calculatePath(game, () async {
        _progressController.add(++currentStep / totalSteps);
        await Future.delayed(Duration.zero);
      });

      _finishModelList.add(
        FinishModel(
          id: game.id,
          result: ResultModel(
            path: calculationResult.path,
            steps: calculationResult.steps,
          ),
        ),
      );
      checkResultModelList.add(CheckResultModel(
        field: game.field,
        path: calculationResult.path,
        start: game.start,
        end: game.end,
      ));
    }
    _checkResultModelListController.add(checkResultModelList);
  }

  Future<bool> sendResult() async {
    _sendDataCheckController.add(true);
    final result = await _repository.sendData(_finishModelList);
    _processResultController.add(result);
    _sendDataCheckController.add(false);
    return result.isErrorOccurred;
  }

  void dispose() {
    _progressController.close();
    _checkResultModelListController.close();
    _sendDataCheckController.close();
    _processResultController.close();
  }
}
