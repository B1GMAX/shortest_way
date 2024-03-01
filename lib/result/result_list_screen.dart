import 'package:flutter/material.dart';
import 'package:shortest_way/check_result/check_result_screen.dart';
import 'package:shortest_way/models/check_result_model.dart';

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
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckResultScreen(
                  checkResult: e,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 1),
                ),
              ),
              child: Center(
                  child: Text(
                e.path,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )),
            ),
          );
        }).toList(),
      ),
    );
  }
}
