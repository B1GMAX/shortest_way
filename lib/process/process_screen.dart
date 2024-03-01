import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortest_way/models/check_result_model.dart';
import 'package:shortest_way/models/game_model.dart';
import 'package:shortest_way/process/process_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
                  'Process Screen',
                ),
              ],
            ),
            leadingWidth: 200,
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
                    child: StreamBuilder<double>(
                      initialData: 0,
                      stream: context.read<ProcessBloc>().progressStream,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data! != 1
                                            ? 'Calculating...'
                                            : 'All calculations has finished, you can send your results to server',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      (snapshot.data! * 100).toInt().toString(),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 25),
                                    CircularPercentIndicator(
                                      radius: 100.0,
                                      lineWidth: 10.0,
                                      percent: snapshot.data!,
                                      progressColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            StreamBuilder<String>(
                                initialData: '',
                                stream: context
                                    .read<ProcessBloc>()
                                    .processErrorMessageStream,
                                builder:
                                    (context, processErrorMessageSnapshot) {
                                  return processErrorMessageSnapshot
                                          .data!.isNotEmpty
                                      ? Column(
                                          children: [
                                            Text(processErrorMessageSnapshot
                                                .data!),
                                            const SizedBox(height: 15),
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                }),
                            if (snapshot.data! == 1)
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
                                      child: const Text('Send data'),
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
