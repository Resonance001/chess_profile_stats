import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/models/provider/navigation_provider.dart';
import 'package:chess/views/navigation_drawer.dart';
import 'package:chess/views/profile/page_view_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _appHeader = 'Lichess App';

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSize = switch (constraints.maxWidth) {
          > mediumWidth => WindowSize.extended,
          >= compactWidth => WindowSize.medium,
          _ => WindowSize.compact,
        };

        final margin =
            windowSize == WindowSize.compact ? compactMargin : mediumMargin;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<DeviceState>().windowSize = windowSize;
        });

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<NavigationState>().resetDestination();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(_appHeader),
            elevation: 20,
          ),
          body: SafeArea(
            child: Row(
              children: <Widget>[
                if (windowSize != WindowSize.compact) const NavRail(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: margin, right: margin),
                    child: const PageViewScreen(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              windowSize == WindowSize.compact ? const BottomBar() : null,
        );
      },
    );
  }
}
