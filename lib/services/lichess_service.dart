import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chess/models/api/performance_stat_model.dart';
import 'package:chess/models/api/rating_history_model.dart';
import 'package:chess/models/api/user_data_model.dart' as uu;
import 'package:chess/models/provider/data_provider.dart';
import 'package:chess/views/profile_page.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<List<Object>> fetchData(String id) async {
  const baseUrl = 'lichess.org';

  final paths = <String>[
    'api/user/$id',
    'api/user/$id/rating-history',
    'api/user/$id/perf/bullet',
    'api/user/$id/perf/blitz',
    'api/user/$id/perf/rapid',
  ];

  final functions = <Function>[
    uu.userDataFromJson,
    ratingHistoryFromJson,
    ...List.filled(3, performanceStatFromJson),
  ];

  final list = <Object>[];

  await Future.wait([
    for (final path in paths) http.get(Uri.https(baseUrl, path)),
  ]).then((response) {
    for (final pairs in IterableZip([response, functions])) {
      final response = pairs[0] as http.Response;
      final decode = pairs[1] as Function;
      list.add(decode(response.body) as Object);
    }
  });
  return list;
}

class LichessService extends StatefulWidget {
  const LichessService({required this.id, super.key});

  final String id;

  @override
  State<LichessService> createState() => _LichessServiceState();
}

class _LichessServiceState extends State<LichessService> {
  late Future<List<Object>> _futureCalls;

  @override
  void initState() {
    super.initState();
    _futureCalls = fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureCalls,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var index = 0;

            final data = snapshot.data as List<Object>;
            final storage = context.read<DataModel>()
              ..userData = data[index] as uu.UserData;
              
            for (final value in TimeControl.values) {
              final ratingHist = data[1] as List<RatingHistory>;

              storage.ratingHistory[value] = ratingHist.isEmpty
                  ? RatingHistory(name: '', points: [])
                  : ratingHist[index];
              storage.performance[value] = data[index + 2] as PerformanceStat;
              index++;
            }

            return const ProfilePage();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const SizedBox();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
