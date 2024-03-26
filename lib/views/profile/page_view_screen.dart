import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Page;

import 'package:chess/constants/breakpoints.dart';
import 'package:chess/models/provider/breakpoint_provider.dart';
import 'package:chess/models/provider/data_provider.dart';
import 'package:chess/models/provider/navigation_provider.dart';
import 'package:chess/views/profile/page.dart';
import 'package:chess/views/profile/page_list.dart';
import 'package:provider/provider.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final _controller = PageController();
  int _currentIndex = 0;

  static const _animationDuration = Duration(milliseconds: 500);
  static const _curve = Curves.easeIn;

  late final List<Page> _pages;
  late final List<int> _partition;

  @override
  void initState() {
    super.initState();
    final pageList = PageList(data: context.read<DataModel>());

    _pages = pageList.getPages();
    _partition = pageList.getPartition();
  }

  @override
  void didChangeDependencies() {
    if (context.watch<NavigationState>().destinationChanged) {
      jumpTo();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextPage() {
    final nav = Provider.of<NavigationState>(context, listen: false);
    if (_currentIndex + 1 == _partition[nav.currDestination + 1]) {
      nav.currDestination++;
    }
    _controller.nextPage(
      curve: _curve,
      duration: _animationDuration,
    );
  }

  void previousPage() {
    final nav = Provider.of<NavigationState>(context, listen: false);
    if (_currentIndex == _partition[nav.currDestination]) {
      nav.currDestination--;
    }
    _controller.previousPage(
      curve: _curve,
      duration: _animationDuration,
    );
  }

  void jumpTo() {
    final nav = Provider.of<NavigationState>(context);

    _controller.animateToPage(
      _partition[nav.currDestination],
      duration: _animationDuration,
      curve: Curves.easeIn,
    );
    
    _currentIndex = _partition[nav.currDestination];
    nav.toggleSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          if (pointerSignal.scrollDelta.dy > 0) {
            nextPage();
          } else {
            previousPage();
          }
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          const sensitivity = 5;

          if (details.delta.dy < -sensitivity) {
            nextPage();
          } else if (details.delta.dy > sensitivity) {
            previousPage();
          }
        },
        onHorizontalDragUpdate: (details) {
          const sensitivity = 5;

          if (details.delta.dx < -sensitivity) {
            nextPage();
          } else if (details.delta.dx > sensitivity) {
            previousPage();
          }
        },
        child: Consumer<DeviceState>(
          builder: (context, device, child) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              scrollDirection: device.windowSize == WindowSize.compact
                  ? Axis.horizontal
                  : Axis.vertical,
              allowImplicitScrolling: true,
              children: _pages,
              onPageChanged: (index) => _currentIndex = index,
            );
          },
        ),
      ),
    );
  }
}
