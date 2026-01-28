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
  Widget build(BuildContext context) {
    final homePageViewModel = locator<HomePageViewModel>();

    return BlocProvider(
      create: (_) => homePageViewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('KIX Sharing (Demo)'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              BlocBuilder<HomePageViewModel, HomePageState>(
                builder: (context, homePageState) =>
                    Text('${homePageState.counter}', style: Theme.of(context).textTheme.headlineMedium),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => homePageViewModel.incrementCounter(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
