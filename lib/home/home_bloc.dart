import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/preferences/preferences.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/game_result_model.dart';

class HomeBloc {
  final textController = TextEditingController();

  final Repository _repository = Repository();

  final _sendDataResultController = BehaviorSubject<GameResultModel>();

  final _sendDataCheckController = BehaviorSubject<bool>();

  Stream<bool> get sendDataCheckStream => _sendDataCheckController.stream;

  Stream<GameResultModel> get sendDataResultStream =>
      _sendDataResultController.stream;

  String _url = '';

  HomeBloc() {
    getUrl();
  }

  void getUrl() async {
    _url = await Preferences.instance.getUrl();
  }

  void setUrl() {
    if (_url.isNotEmpty) {
      textController.text = _url;
    }
  }

  Future<List<GameModel>> getData() async {
    _sendDataCheckController.add(true);
    final result = await _repository.getFieldsData(textController.text);
    _sendDataCheckController.add(false);
    if (result != null) {
      await Preferences.instance.saveUrl(textController.text);
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
