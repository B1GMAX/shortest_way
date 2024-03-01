import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shortest_way/doman/preferences/preferences.dart';
import 'package:shortest_way/doman/repository/repository.dart';
import 'package:shortest_way/models/game_model.dart';

class HomeBloc {
  final textController = TextEditingController();

  Repository repository = Repository();

  final _errorMessageController = BehaviorSubject<String>();

  Stream<String> get errorMessageStream => _errorMessageController.stream;

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
    final result = await repository.getFieldsData(url);
    if (result != null) {
      _errorMessageController.add(result.message);
      return result.gameModel;
    }
    return [];
  }

  void dispose(){
    _errorMessageController.close();
    textController.dispose();
  }
}
