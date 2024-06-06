import 'package:flutter/material.dart';
import 'package:shortest_way/widgets/general_app_bar.dart';
import 'package:shortest_way/models/preview_result_model.dart';

import 'element_widget.dart';

class ResultListScreen extends StatelessWidget {
  final List<PreviewResultModel> finishModeList;

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
            previewResultModel: e,
            isOneElement: finishModeList.length == 1,
          );
        }).toList(),
      ),
    );
  }
}
