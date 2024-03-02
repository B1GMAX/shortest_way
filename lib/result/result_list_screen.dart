import 'package:flutter/material.dart';
import 'package:shortest_way/general_app_bar.dart';
import 'package:shortest_way/models/check_result_model.dart';

import 'element_widget.dart';

class ResultListScreen extends StatelessWidget {
  final List<CheckResultModel> finishModeList;

  const ResultListScreen({required this.finishModeList, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        text: 'Result list screen',
      ),
      body: Column(
        children: finishModeList.map((e) {
          return ElementWidget(
            checkResultModel: e,
            isOneElement: finishModeList.length == 1,
          );
        }).toList(),
      ),
    );
  }
}
