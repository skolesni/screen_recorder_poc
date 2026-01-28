import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_recorder_poc/injection.dart';
import 'package:screen_recorder_poc/view_model.dart';

/// Implements the HomePage widget.
@immutable
final class HomePage extends StatelessWidget {
  /// Creates the HomePage widget.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
    BlocProvider(
      create: (_) => locator<HomePageViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('KIX Sharing (Demo)'),
        ),
        body: Center(
          child: BlocBuilder<HomePageViewModel, HomePageState>(
            builder: (context, state) {
              final viewModel = context.read<HomePageViewModel>();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.isStartButtonVisible)
                    ElevatedButton.icon(
                      onPressed: state.isStartButtonEnabled ? () => viewModel.startRecording() : null,
                      icon: const Icon(Icons.fiber_manual_record),
                      label: const Text('Start Recording'),
                    ),
                  if (state.isStopButtonVisible)
                    ElevatedButton.icon(
                      onPressed: state.isStopButtonEnabled ? () => viewModel.stopRecording() : null,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop Recording'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    ),
                  const SizedBox(height: 32),
                  if (state.isPlayButtonVisible)
                    ElevatedButton.icon(
                      onPressed: state.isPlayButtonEnabled ? () => viewModel.playRecording() : null,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play Recording'),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
}
