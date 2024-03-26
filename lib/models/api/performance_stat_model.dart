import 'dart:convert';

PerformanceStat performanceStatFromJson(String str) =>
    PerformanceStat.fromJson(json.decode(str) as Map<String, dynamic>);

String performanceStatToJson(PerformanceStat data) =>
    json.encode(data.toJson());

class PerformanceStat {
  Perf perf;
  int rank;
  double percentile;
  Stat stat;

  PerformanceStat({
    required this.perf,
    required this.rank,
    required this.percentile,
    required this.stat,
  });

  factory PerformanceStat.fromJson(Map<String, dynamic> json) =>
      PerformanceStat(
        perf: Perf.fromJson(json['perf'] as Map<String, dynamic>),
        rank: (json['rank'] ?? 0) as int,
        percentile: (json['percentile'] ?? 0) as double,
        stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'perf': perf.toJson(),
        'rank': rank,
        'percentile': percentile,
        'stat': stat.toJson(),
      };
}

class Perf {
  Glicko glicko;
  int nb;
  int progress;

  Perf({
    required this.glicko,
    required this.nb,
    required this.progress,
  });

  factory Perf.fromJson(Map<String, dynamic> json) => Perf(
        glicko: Glicko.fromJson(json['glicko'] as Map<String, dynamic>),
        nb: json['nb'] as int,
        progress: json['progress'] as int,
      );

  Map<String, dynamic> toJson() => {
        'glicko': glicko.toJson(),
        'nb': nb,
        'progress': progress,
      };
}

class Glicko {
  double rating;
  double deviation;
  bool provisional;

  Glicko({
    required this.rating,
    required this.deviation,
    required this.provisional,
  });

  factory Glicko.fromJson(Map<String, dynamic> json) => Glicko(
        rating: json['rating'] as double,
        deviation: json['deviation'] as double,
        provisional: (json['provisional'] ?? false) as bool,
      );

  Map<String, dynamic> toJson() => {
        'rating': rating,
        'deviation': deviation,
        'provisional': provisional,
      };
}

class Stat {
  PerfType perfType;
  Est highest;
  Est lowest;
  BestWins bestWins;
  BestWins worstLosses;
  Count count;
  ResultStreak resultStreak;
  PlayStreak playStreak;

  Stat({
    required this.perfType,
    required this.highest,
    required this.lowest,
    required this.bestWins,
    required this.worstLosses,
    required this.count,
    required this.resultStreak,
    required this.playStreak,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        perfType: PerfType.fromJson(json['perfType'] as Map<String, dynamic>),
        highest: Est.fromJson(
          (json['highest'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        lowest: Est.fromJson(
          (json['lowest'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        bestWins: BestWins.fromJson(json['bestWins'] as Map<String, dynamic>),
        worstLosses:
            BestWins.fromJson(json['worstLosses'] as Map<String, dynamic>),
        count: Count.fromJson(json['count'] as Map<String, dynamic>),
        resultStreak:
            ResultStreak.fromJson(json['resultStreak'] as Map<String, dynamic>),
        playStreak:
            PlayStreak.fromJson(json['playStreak'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'perfType': perfType.toJson(),
        'highest': highest.toJson(),
        'lowest': lowest.toJson(),
        'bestWins': bestWins.toJson(),
        'worstLosses': worstLosses.toJson(),
        'count': count.toJson(),
        'resultStreak': resultStreak.toJson(),
        'playStreak': playStreak.toJson(),
      };
}

class BestWins {
  List<Result> results;

  BestWins({
    required this.results,
  });

  factory BestWins.fromJson(Map<String, dynamic> json) {
    final resultsData = json['results'] as List<dynamic>?;

    return BestWins(
      results: resultsData != null
          ? resultsData
              .map(
                (resultData) =>
                    Result.fromJson(resultData as Map<String, dynamic>),
              )
              .toList()
          : <Result>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int opRating;
  OpId opId;
  DateTime at;
  String gameId;

  Result({
    required this.opRating,
    required this.opId,
    required this.at,
    required this.gameId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        opRating: (json['opRating'] ?? 0) as int,
        opId: OpId.fromJson(json['opId'] as Map<String, dynamic>),
        at: DateTime.parse((json['at'] ?? '').toString()),
        gameId: json['gameId'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'opRating': opRating,
        'opId': opId.toJson(),
        'at': at.toIso8601String(),
        'gameId': gameId,
      };
}

class OpId {
  String id;
  String name;

  OpId({
    required this.id,
    required this.name,
  });

  factory OpId.fromJson(Map<String, dynamic> json) => OpId(
        id: json['id'].toString(),
        name: json['name'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Count {
  int all;
  int rated;
  int win;
  int loss;
  int draw;
  int tour;
  int berserk;
  double opAvg;
  int seconds;
  int disconnects;

  Count({
    required this.all,
    required this.rated,
    required this.win,
    required this.loss,
    required this.draw,
    required this.tour,
    required this.berserk,
    required this.opAvg,
    required this.seconds,
    required this.disconnects,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        all: json['all'] as int,
        rated: json['rated'] as int,
        win: json['win'] as int,
        loss: json['loss'] as int,
        draw: json['draw'] as int,
        tour: json['tour'] as int,
        berserk: json['berserk'] as int,
        opAvg: json['opAvg'] as double,
        seconds: json['seconds'] as int,
        disconnects: json['disconnects'] as int,
      );

  Map<String, dynamic> toJson() => {
        'all': all,
        'rated': rated,
        'win': win,
        'loss': loss,
        'draw': draw,
        'tour': tour,
        'berserk': berserk,
        'opAvg': opAvg,
        'seconds': seconds,
        'disconnects': disconnects,
      };
}

class Est {
  int? estInt;
  DateTime? at;
  String? gameId;

  Est({
    this.estInt,
    this.at,
    this.gameId,
  });

  factory Est.fromJson(Map<String, dynamic> json) => Est(
        estInt: (json['int'] ?? 0) as int,
        at: DateTime.tryParse((json['at'] ?? '') as String),
        gameId: json['gameId'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'int': estInt,
        'at': at?.toIso8601String(),
        'gameId': gameId,
      };
}

class PerfType {
  String key;
  String name;

  PerfType({
    required this.key,
    required this.name,
  });

  factory PerfType.fromJson(Map<String, dynamic> json) => PerfType(
        key: json['key'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'name': name,
      };
}

class PlayStreak {
  Nb nb;
  Nb time;
  DateTime? lastDate;

  PlayStreak({
    required this.nb,
    required this.time,
    required this.lastDate,
  });

  factory PlayStreak.fromJson(Map<String, dynamic> json) => PlayStreak(
        nb: Nb.fromJson(json['nb'] as Map<String, dynamic>),
        time: Nb.fromJson(json['time'] as Map<String, dynamic>),
        lastDate: DateTime.tryParse((json['lastDate'] ?? '') as String),
      );

  Map<String, dynamic> toJson() => {
        'nb': nb.toJson(),
        'time': time.toJson(),
        'lastDate': lastDate?.toIso8601String(),
      };
}

class Nb {
  Cur cur;
  Max max;

  Nb({
    required this.cur,
    required this.max,
  });

  factory Nb.fromJson(Map<String, dynamic> json) => Nb(
        cur: Cur.fromJson(json['cur'] as Map<String, dynamic>),
        max: Max.fromJson(json['max'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cur': cur.toJson(),
        'max': max.toJson(),
      };
}

class Cur {
  int v;

  Cur({
    required this.v,
  });

  factory Cur.fromJson(Map<String, dynamic> json) => Cur(
        v: json['v'] as int,
      );

  Map<String, dynamic> toJson() => {
        'v': v,
      };
}

class Max {
  int v;
  From from;
  From to;

  Max({
    required this.v,
    required this.from,
    required this.to,
  });

  factory Max.fromJson(Map<String, dynamic> json) => Max(
        v: (json['v'] ?? 0) as int,
        from: From.fromJson(
          (json['from'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        to: From.fromJson(
          (json['to'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'v': v,
        'from': from.toJson(),
        'to': to.toJson(),
      };
}

class From {
  DateTime? at;
  String gameId;

  From({
    required this.at,
    required this.gameId,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        at: DateTime.tryParse((json['at'] ?? '') as String),
        gameId: (json['gameId'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => {
        'at': at?.toIso8601String(),
        'gameId': gameId,
      };
}

class ResultStreak {
  Nb win;
  Loss loss;

  ResultStreak({
    required this.win,
    required this.loss,
  });

  factory ResultStreak.fromJson(Map<String, dynamic> json) => ResultStreak(
        win: Nb.fromJson(json['win'] as Map<String, dynamic>),
        loss: Loss.fromJson(json['loss'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'win': win.toJson(),
        'loss': loss.toJson(),
      };
}

class Loss {
  Max cur;
  Max max;

  Loss({
    required this.cur,
    required this.max,
  });

  factory Loss.fromJson(Map<String, dynamic> json) => Loss(
        cur: Max.fromJson(json['cur'] as Map<String, dynamic>),
        max: Max.fromJson(json['max'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cur': cur.toJson(),
        'max': max.toJson(),
      };
}
