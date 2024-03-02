import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/models/calculate.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/finish_model.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';
import 'package:shortest_way/models/result_model.dart';

class ProcessBloc {
  final List<GameModel> gameModelList;

  final List<FinishModel> finishModelList = [];

  Repository repository = Repository();

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

  ProcessBloc(this.gameModelList) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _findPath());
  }

  Calculations calculations = Calculations();

  void _findPath() async {
    final List<CheckResultModel> checkResultModelList = [];
    final double totalProgressSteps = gameModelList.length * 1.5;
    for (final game in gameModelList) {
      final calculationResult = calculations.calculatePath(game, () async {
        for (double currentProgress = 0;
            currentProgress < 1.5;
            currentProgress += (1 / totalProgressSteps)) {
          _progressController.add(currentProgress > 1 ? 1 : currentProgress);
          await Future.delayed(const Duration(milliseconds: 100));
        }
      });
      finishModelList.add(
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
    final result = await repository.sendData(finishModelList);
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
