import 'package:flutter/material.dart';
import 'package:shortest_way/models/check_result_model.dart';

import 'element_widget.dart';

class ResultListScreen extends StatelessWidget {
  final List<CheckResultModel> finishModeList;

  const ResultListScreen({required this.finishModeList, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const Text(
              'Result list screen',
            ),
          ],
        ),
        leadingWidth: 200,
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
