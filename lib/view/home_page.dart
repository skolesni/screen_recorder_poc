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
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Add recording controls
            ],
          ),
        ),
      ),
    );
  }
}
