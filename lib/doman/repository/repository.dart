import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shortest_way/models/finish_model.dart';
import 'package:shortest_way/models/game_result_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';

class Repository {
  final dio = Dio();

  static String url = 'https://flutter.webspark.dev/flutter/api';

  Future<GameResultModel?> getFieldsData(String inputUrl) async {
    try {
      final response = await dio.get(inputUrl);
      if (response.statusCode == 200) {
        return GameResultModel.fromJson(response.data);
      } else {
        return GameResultModel(
            error: true,
            message: 'Set valid API base URL in order tu continue',
            gameModel: []);
      }
    } catch (e) {
      return GameResultModel(
          error: true,
          message: 'Set valid API base URL in order tu continue',
          gameModel: []);
    }
  }

  Future<ProcessResultModel> sendData(List<FinishModel> finishModelList) async {
    try {
      final response = await dio.post(url,
          data: jsonEncode(finishModelList.map((e) => e.toJson()).toList()));
      if (response.statusCode == 200) {
        return ProcessResultModel(
            isErrorOccurred: response.data['error'],
            message: response.data['message']);
      } else {
        return ProcessResultModel(
            isErrorOccurred: true, message: 'Something went wrong');
      }
    } catch (e) {
      return ProcessResultModel(
          isErrorOccurred: true, message: 'Something went wrong');
    }
  }
}
