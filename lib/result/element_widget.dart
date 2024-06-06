import 'package:flutter/material.dart';
import 'package:shortest_way/models/preview_result_model.dart';
import 'package:shortest_way/preview_result/preview_result_screen.dart';

class ElementWidget extends StatefulWidget {
  final bool isOneElement;
  final PreviewResultModel previewResultModel;

  const ElementWidget({
    required this.previewResultModel,
    required this.isOneElement,
    super.key,
  });

  @override
  State<ElementWidget> createState() => _ElementWidgetState();
}

class _ElementWidgetState extends State<ElementWidget> {
  int _count = 1;

  bool get _countStart => _count == 1;

  bool get _countEnd => _count == 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.isOneElement || _countEnd
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewResultScreen(
                  previewResult: widget.previewResultModel,
                ),
              ),
            )
          : setState(() {
              _count++;
            }),
      child: Container(
        margin: EdgeInsets.all(_countStart ? 5 : 10),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(color: Colors.black12, width: 1),
          ),
          color: _countStart ? Colors.black : Colors.transparent,
        ),
        child: Center(
          child: Text(
            widget.previewResultModel.path,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
