import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/finish_model.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';
import 'package:shortest_way/models/result_model.dart';
import 'package:shortest_way/models/steps_model.dart';

class ProcessBloc {
  final List<GameModel> gameModelList;

  final List<FinishModel> finishModelList = [];

  Repository repository = Repository();

  final _progressController = BehaviorSubject<double>();

  final _checkResultModelListController =
      BehaviorSubject<List<CheckResultModel>>();

  final _sendDataCheckController = BehaviorSubject<bool>();

  final _processErrorMessageController = BehaviorSubject<String>();

  Stream<bool> get sendDataCheckStream => _sendDataCheckController.stream;

  Stream<String> get processErrorMessageStream =>
      _processErrorMessageController.stream;

  Stream<double> get progressStream => _progressController.stream;

  Stream<List<CheckResultModel>> get checkResulModelListStream =>
      _checkResultModelListController.stream;

  ProcessBloc(this.gameModelList) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _findPath());
  }

  void _findPath() async {
    double progress = 0;
    final List<CheckResultModel> checkResultModelList = [];
    for (final game in gameModelList) {
      String path = '';
      final List<StepsModel> steps = [];
      steps.add(
          StepsModel(x: game.start.x.toString(), y: game.start.y.toString()));
      int currentX = game.start.x;
      int currentY = game.start.y;
      path = '($currentX,$currentY)->';
      while (currentX != game.end.x || currentY != game.end.y) {
        while (progress < 1) {
          progress += 0.1;
          _progressController.add(progress > 1 ? 1 : progress);
          await Future.delayed(const Duration(milliseconds: 90));
        }
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
      finishModelList.add(
        FinishModel(
          id: game.id,
          result: ResultModel(
            path: path,
            steps: steps,
          ),
        ),
      );
      checkResultModelList.add(CheckResultModel(
        field: game.field,
        path: path,
        start: game.start,
        end: game.end,
      ));
    }
    _checkResultModelListController.add(checkResultModelList);
  }

  Future<bool> sendResult() async {
    _sendDataCheckController.add(true);
    final result = await repository.sendData(finishModelList);
    _processErrorMessageController.add(result.message);
    _sendDataCheckController.add(false);
    return result.isErrorOccurred;
  }

  void dispose() {
    _progressController.close();
    _checkResultModelListController.close();
    _sendDataCheckController.close();
    _processErrorMessageController.close();
  }
}
