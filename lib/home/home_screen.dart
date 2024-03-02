import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortest_way/general_app_bar.dart';
import 'package:shortest_way/models/game_result_model.dart';
import 'package:shortest_way/process/process_screen.dart';

import 'home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => HomeBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, _) {
        return Scaffold(
          appBar: const GeneralAppBar(
            text: 'Home Screen',
            isHomePage: true,
            width: 150,
          ),
          body: StreamBuilder<bool>(
            initialData: false,
            stream: context.read<HomeBloc>().sendDataCheckStream,
            builder: (context, sendDataCheckSnapshot) {
              return Stack(
                children: [
                  if (sendDataCheckSnapshot.data!)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 25),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              StreamBuilder<GameResultModel>(
                                stream: context
                                    .read<HomeBloc>()
                                    .sendDataResultStream,
                                builder: (context, snapshot) {
                                  return snapshot.hasData &&
                                          snapshot.data!.error
                                      ? Column(
                                          children: [
                                            Text(snapshot.data!.message),
                                            const SizedBox(height: 25),
                                          ],
                                        )
                                      : const SizedBox();
                                },
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        context.read<HomeBloc>().setUrl(),
                                    icon: const Icon(Icons.swap_horiz),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: context
                                          .read<HomeBloc>()
                                          .textController,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF40C4FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onPressed: () async {
                              final list = await context
                                  .read<HomeBloc>()
                                  .getData(context
                                      .read<HomeBloc>()
                                      .textController
                                      .text);
                              if (context.mounted && list.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProcessScreen(
                                        gameList: list,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Text('Start counting process'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
