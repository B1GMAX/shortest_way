import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortest_way/general_app_bar.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/models/procces_result_model.dart';
import 'package:shortest_way/process/process_bloc.dart';
import 'package:shortest_way/process/progress_widget.dart';
import 'package:shortest_way/result/result_list_screen.dart';

class ProcessScreen extends StatelessWidget {
  final List<GameModel> gameList;

  const ProcessScreen({
    required this.gameList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<ProcessBloc>(
      lazy: false,
      dispose: (context, bloc) => bloc.dispose(),
      create: (context) => ProcessBloc(gameList),
      builder: (context, _) {
        return Scaffold(
          appBar: const GeneralAppBar(
            text: 'Process Screen',
          ),
          body: StreamBuilder<bool>(
            initialData: false,
            stream: context.read<ProcessBloc>().sendDataCheckStream,
            builder: (context, sendDataCheckSnapshot) {
              return Stack(
                children: [
                  if (sendDataCheckSnapshot.hasData &&
                      sendDataCheckSnapshot.data!)
                    const Center(child: CircularProgressIndicator()),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: StreamBuilder<bool>(
                      initialData: true,
                      stream: context.read<ProcessBloc>().progressStream,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            ProgressWidget(value: snapshot.data!),
                            StreamBuilder<ProcessResultModel>(
                                stream: context
                                    .read<ProcessBloc>()
                                    .processResultStream,
                                builder: (context, processResultSnapshot) {
                                  return processResultSnapshot.hasData &&
                                          processResultSnapshot
                                              .data!.isErrorOccurred
                                      ? Column(
                                          children: [
                                            Text(processResultSnapshot
                                                .data!.message),
                                            const SizedBox(height: 15),
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                }),
                            if (!snapshot.data!)
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: StreamBuilder<List<CheckResultModel>>(
                                  initialData: const [],
                                  stream: context
                                      .read<ProcessBloc>()
                                      .checkResulModelListStream,
                                  builder:
                                      (context, checkResultModelListSnapshot) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF40C4FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (sendDataCheckSnapshot.hasData &&
                                            !sendDataCheckSnapshot.data!) {
                                          final isErrorOccurred = await context
                                              .read<ProcessBloc>()
                                              .sendResult();
                                          if (context.mounted &&
                                              !isErrorOccurred) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ResultListScreen(
                                                  finishModeList:
                                                      checkResultModelListSnapshot
                                                          .data!,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                          'Send result to the server'),
                                    );
                                  },
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
