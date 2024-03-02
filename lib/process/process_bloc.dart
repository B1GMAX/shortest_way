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

  final _progressController = BehaviorSubject<bool>();

  final _checkResultModelListController =
      BehaviorSubject<List<CheckResultModel>>();

  final _sendDataCheckController = BehaviorSubject<bool>();

  final _processResultController = BehaviorSubject<ProcessResultModel>();

  Stream<bool> get sendDataCheckStream => _sendDataCheckController.stream;

  Stream<ProcessResultModel> get processResultStream =>
      _processResultController.stream;

  Stream<bool> get progressStream => _progressController.stream;

  Stream<List<CheckResultModel>> get checkResulModelListStream =>
      _checkResultModelListController.stream;

  ProcessBloc(this.gameModelList) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _findPath());
  }

  Calculations calculations = Calculations();

  void _findPath() async {
    final List<CheckResultModel> checkResultModelList = [];
    _progressController.add(true);
    for (final game in gameModelList) {
      final calculationResult = calculations.calculatePath(game);
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
    _progressController.add(false);
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
