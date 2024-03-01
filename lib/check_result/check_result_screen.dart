import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortest_way/check_result/check_result_bloc.dart';
import 'package:shortest_way/models/check_result_model.dart';

class CheckResultScreen extends StatelessWidget {
  final CheckResultModel checkResult;

  const CheckResultScreen({required this.checkResult, super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CheckResultBloc>(
      lazy: false,
      create: (context) => CheckResultBloc(checkResult),
      builder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Preview Screen',
                ),
              ],
            ),
            leadingWidth: 200,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 340,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: checkResult.field[0].length,
                    childAspectRatio: 1.25,
                  ),
                  itemCount:
                      checkResult.field.length * checkResult.field[0].length,
                  itemBuilder: (context, index) {
                    int row = index ~/ checkResult.field[0].length;
                    int col = index % checkResult.field[0].length;
                    String cell = checkResult.field[row][col];
                    final color = context
                        .read<CheckResultBloc>()
                        .getColor(index, cell, row, col);

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: context
                            .read<CheckResultBloc>()
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
              Text(checkResult.path),
            ],
          ),
        );
      },
    );
  }
}
