import 'package:flutter/material.dart';

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/data/navigation_data.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/models/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class Destination {
  const Destination(this.label, this.icon);

  final String label;
  final Widget icon;
}

final _destinations = List.generate(
  label.length,
  (index) => Destination(label[index], icon[index]),
);

class NavRail extends StatefulWidget {
  const NavRail({super.key});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationState>(context);
    final windowSize = Provider.of<DeviceState>(context).windowSize;

    final isExtended = windowSize == WindowSize.extended;
    final labelType =
        isExtended ? NavigationRailLabelType.none : NavigationRailLabelType.all;

    var selectedIndex = nav.currDestination;

    return NavigationRail(
      elevation: 14,
      extended: isExtended,
      minExtendedWidth: 160,
      useIndicator: true,
      labelType: labelType,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        if (selectedIndex != index) {
          setState(() {
            selectedIndex = index;
            nav
              ..currDestination = index
              ..toggleSelection();
          });
        }
      },
      destinations: _destinations.map((Destination destination) {
        return NavigationRailDestination(
          label: Text(destination.label),
          icon: destination.icon,
        );
      }).toList(),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationState>(context);
    var selectedIndex = nav.currDestination;

    return NavigationBar(
      elevation: 1,
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        if (selectedIndex != index) {
          setState(() {
            selectedIndex = index;
            nav
              ..currDestination = index
              ..toggleSelection();
          });
        }
      },
      destinations: _destinations.map(
        (Destination destination) {
          return NavigationDestination(
            label: destination.label,
            icon: destination.icon,
          );
        },
      ).toList(),
    );
  }
}
