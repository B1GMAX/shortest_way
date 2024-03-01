import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Home Screen',
              ),
            ),
            leadingWidth: 150,
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 25),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                          initialData: '',
                          stream: context.read<HomeBloc>().errorMessageStream,
                          builder: (context, snapshot) {
                            return snapshot.data!.isNotEmpty
                                ? Column(
                                    children: [
                                      Text(snapshot.data!),
                                      const SizedBox(height: 25),
                                    ],
                                  )
                                : const SizedBox();
                          }),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => context.read<HomeBloc>().setUrl(),
                            icon: const Icon(Icons.swap_horiz),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller:
                                  context.read<HomeBloc>().textController,
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
                      final list = await context.read<HomeBloc>().getData(
                          context.read<HomeBloc>().textController.text);
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
        );
      },
    );
  }
}
