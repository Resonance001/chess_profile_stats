import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/views/home/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _appHeader = 'Chess Profile & Stats ';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text(_appHeader),
        elevation: 20,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final windowSize = switch (constraints.maxWidth) {
            > mediumWidth => WindowSize.extended,
            >= compactWidth => WindowSize.medium,
            _ => WindowSize.compact,
          };

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DeviceState>().windowSize = windowSize;
          });

          final width = switch (windowSize) {
            WindowSize.extended => 700.0,
            WindowSize.medium => 480.0,
            WindowSize.compact => 300.0,
          };

          return Center(
            child: SizedBox(
              width: width,
              child: const LoginView(),
            ),
          );
        },
      ),
    );
  }
}
