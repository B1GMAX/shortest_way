import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shortest_way/models/finish_model.dart';
import 'package:shortest_way/models/game_result_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';

class Repository {
  final dio = Dio();

  static String url = 'https://flutter.webspark.dev/flutter/api';

  Future<GameResultModel?> getFieldsData(String inputUrl) async {
    final response = await dio.get(inputUrl);
    if (response.statusCode == 200) {
      try {
        return  GameResultModel.fromJson(response.data);
      } catch (e, s) {
        print('error - e; stack - $s');
      }
    }
    return null;
  }

  Future<ProcessResultModel> sendData(List<FinishModel> finishModelList) async {
    final response = await dio.post(url,
        data: jsonEncode(finishModelList.map((e) => e.toJson()).toList()));
   if(response.statusCode == 200) {
      try {
        return ProcessResultModel(
            isErrorOccurred: response.data['error'],
            message: response.data['message']);
      } catch (e, s) {
        print('sendData error - $e; stack - $s');
      }
    }
    return ProcessResultModel(isErrorOccurred: false, message: '');
  }
}
