import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/preferences/preferences.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/game_result_model.dart';

class HomeBloc {
  final textController = TextEditingController();

  Repository repository = Repository();

  final _sendDataResultController = BehaviorSubject<GameResultModel>();

  final _sendDataCheckController = BehaviorSubject<bool>();

  Stream<bool> get sendDataCheckStream => _sendDataCheckController.stream;

  Stream<GameResultModel> get sendDataResultStream =>
      _sendDataResultController.stream;

  String url = '';

  HomeBloc() {
    getUrl();
  }

  void getUrl() async {
    url = await Preferences.instance.getUrl();
  }

  void setUrl() {
    if (url.isNotEmpty) {
      textController.text = url;
    }
  }

  Future<List<GameModel>> getData(String url) async {
    _sendDataCheckController.add(true);
    final result = await repository.getFieldsData(url);
    _sendDataCheckController.add(false);
    if (result != null) {
      await Preferences.instance.saveUrl(url);
      _sendDataResultController.add(result);
      return result.gameModel;
    }
    return [];
  }

  void dispose() {
    _sendDataResultController.close();
    textController.dispose();
    _sendDataCheckController.close();
  }
}
