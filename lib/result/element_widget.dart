import 'package:flutter/material.dart';
import 'package:shortest_way/check_result/check_result_screen.dart';
import 'package:shortest_way/models/check_result_model.dart';

class ElementWidget extends StatefulWidget {
  final bool isOneElement;
  final CheckResultModel checkResultModel;

  const ElementWidget({
    required this.checkResultModel,
    required this.isOneElement,
    super.key,
  });

  @override
  State<ElementWidget> createState() => _ElementWidgetState();
}

class _ElementWidgetState extends State<ElementWidget> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.isOneElement || count == 3
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckResultScreen(
                  checkResult: widget.checkResultModel,
                ),
              ),
            )
          : setState(() {
              count ++;
            }),
      child: Container(
        margin: EdgeInsets.all(count == 1 ? 5 : 10),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(color: Colors.black12, width: 1),
          ),
          color: count == 1 ? Colors.black : Colors.transparent,
        ),
        child: Center(
          child: Text(
            widget.checkResultModel.path,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
