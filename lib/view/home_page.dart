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

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.isStartButtonVisible)
                      ElevatedButton.icon(
                        onPressed: state.isStartButtonEnabled ? () => viewModel.startRecording() : null,
                        icon: const Icon(Icons.fiber_manual_record),
                        label: const Text('Start Recording'),
                      ),
                    if (state.isShowButtonVisible)
                      ...[
                        const Text('Press either the icon above or the Show recording button below to access UI to stop recording or toggle the microphone audio.', textAlign: .center,),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                        onPressed: state.isShowButtonEnabled ? () => viewModel.showRecording() : null,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Show Recording'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                      )],
                    const SizedBox(height: 32),
                    if (state.isPlayButtonVisible)
                      ElevatedButton.icon(
                        onPressed: state.isPlayButtonEnabled ? () => viewModel.playRecording() : null,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play Recording'),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
}
