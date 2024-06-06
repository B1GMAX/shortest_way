import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortest_way/widgets/general_app_bar.dart';
import 'package:shortest_way/models/preview_result_model.dart';

import 'preview_result_bloc.dart';

class PreviewResultScreen extends StatelessWidget {
  final PreviewResultModel previewResult;

  const PreviewResultScreen({required this.previewResult, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Provider<PreviewResultBloc>(
      lazy: false,
      create: (context) => PreviewResultBloc(previewResult),
      builder: (context, index) {
        return Scaffold(
          appBar: const GeneralAppBar(
            text: 'Preview Screen',
          ),
          body: Column(
            children: [
              SizedBox(
                height: height * 0.481,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: previewResult.field[0].length,
                    childAspectRatio: 1.25,
                  ),
                  itemCount:
                      previewResult.field.length * previewResult.field[0].length,
                  itemBuilder: (context, index) {
                    int row = index ~/ previewResult.field[0].length;
                    int col = index % previewResult.field[0].length;
                    String cell = previewResult.field[row][col];
                    final color = context
                        .read<PreviewResultBloc>()
                        .getColor(index, cell, row, col);

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: context
                            .read<PreviewResultBloc>()
                            .getColor(index, cell, row, col),
                      ),
                      child: Center(
                        child: Text(
                          '($col, $row)', // Displaying the coordinates
                          style: TextStyle(
                            color: color == Colors.black
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(previewResult.path),
            ],
          ),
        );
      },
    );
  }
}
