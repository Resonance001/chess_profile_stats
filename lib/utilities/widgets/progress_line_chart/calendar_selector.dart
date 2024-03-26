import 'package:flutter/material.dart';
import 'package:chess/models/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class CalendarSelector extends StatefulWidget {
  const CalendarSelector({super.key});

  @override
  State<CalendarSelector> createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  Calendar currentCalendar = Calendar.threeMonths;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: [
        for (final calendar in Calendar.values)
          ButtonSegment(
            value: calendar,
            icon: Icon(calendar.icon),
            label: Text(
              calendar.label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
      ],
      selected: {
        currentCalendar,
      },
      onSelectionChanged: (newCalendar) {
        setState(() {
          context.read<NavigationState>().calendar = newCalendar.first;
        });
      },
    );
  }
}
