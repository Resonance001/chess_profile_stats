import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String id;
  String username;
  Perfs perfs;
  int createdAt;
  bool disabled;
  bool tosViolation;
  Profile profile;
  int seenAt;
  bool patron;
  bool verified;
  PlayTime playTime;
  String title;
  String url;
  String playing;
  Map<String, int> count;
  bool streaming;
  Streamer streamer;
  bool followable;
  bool following;
  bool blocking;
  bool followsYou;

  UserData({
    required this.id,
    required this.username,
    required this.perfs,
    required this.createdAt,
    required this.disabled,
    required this.tosViolation,
    required this.profile,
    required this.seenAt,
    required this.patron,
    required this.verified,
    required this.playTime,
    required this.title,
    required this.url,
    required this.playing,
    required this.count,
    required this.streaming,
    required this.streamer,
    required this.followable,
    required this.following,
    required this.blocking,
    required this.followsYou,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as String,
        username: json['username'] as String,
        perfs: Perfs.fromJson(json['perfs'] as Map<String, dynamic>),
        createdAt: json['createdAt'] as int,
        disabled: (json['disabled'] ?? false) as bool,
        tosViolation: (json['tosViolation'] ?? false) as bool,
        profile: Profile.fromJson(
          (json['profile'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        seenAt: (json['seenAt'] ?? json['createdAt']) as int,
        patron: (json['patron'] ?? false) as bool,
        verified: (json['verified'] ?? false) as bool,
        playTime: PlayTime.fromJson(json['playTime'] as Map<String, dynamic>),
        title: json['title'].toString(),
        url: json['url'] as String,
        playing: json['playing'].toString(),
        count: Map<String, int>.from(json['count'] as Map<dynamic, dynamic>)
            .map(MapEntry<String, int>.new),
        streaming: (json['streaming'] ?? false) as bool,
        streamer: Streamer.fromJson(
          (json['streamer'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        followable: (json['followable'] ?? true) as bool,
        following: (json['following'] ?? false) as bool,
        blocking: (json['blocking'] ?? false) as bool,
        followsYou: (json['followsYou'] ?? false) as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'perfs': perfs.toJson(),
        'createdAt': createdAt,
        'disabled': disabled,
        'tosViolation': tosViolation,
        'profile': profile.toJson(),
        'seenAt': seenAt,
        'patron': patron,
        'verified': verified,
        'playTime': playTime.toJson(),
        'title': title,
        'url': url,
        'playing': playing,
        'count':
            Map<String, dynamic>.from(count).map(MapEntry<String, dynamic>.new),
        'streaming': streaming,
        'streamer': streamer.toJson(),
        'followable': followable,
        'following': following,
        'blocking': blocking,
        'followsYou': followsYou,
      };
}

class Perfs {
  TimeControl chess960;
  TimeControl atomic;
  TimeControl racingKings;
  TimeControl ultraBullet;
  TimeControl blitz;
  TimeControl kingOfTheHill;
  TimeControl bullet;
  TimeControl correspondence;
  TimeControl horde;
  TimeControl puzzle;
  TimeControl classical;
  TimeControl rapid;
  Puzzle storm;
  Puzzle racer;
  Puzzle streak;

  Perfs({
    required this.chess960,
    required this.atomic,
    required this.racingKings,
    required this.ultraBullet,
    required this.blitz,
    required this.kingOfTheHill,
    required this.bullet,
    required this.correspondence,
    required this.horde,
    required this.puzzle,
    required this.classical,
    required this.rapid,
    required this.storm,
    required this.racer,
    required this.streak,
  });

  factory Perfs.fromJson(Map<String, dynamic> json) => Perfs(
        chess960: TimeControl.fromJson(
          (json['chess960'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        atomic: TimeControl.fromJson(
          (json['atomic'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        racingKings: TimeControl.fromJson(
          (json['racingKings'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        ultraBullet: TimeControl.fromJson(
          (json['ultraBullet'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        blitz: TimeControl.fromJson(
          (json['blitz'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        kingOfTheHill: TimeControl.fromJson(
          (json['kingOfTheHill'] ?? <String, dynamic>{})
              as Map<String, dynamic>,
        ),
        bullet: TimeControl.fromJson(
          (json['bullet'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        correspondence: TimeControl.fromJson(
          (json['correspondence'] ?? <String, dynamic>{})
              as Map<String, dynamic>,
        ),
        horde: TimeControl.fromJson(
          (json['horde'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        puzzle: TimeControl.fromJson(
          (json['puzzle'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        classical: TimeControl.fromJson(
          (json['classical'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        rapid: TimeControl.fromJson(
          (json['rapid'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        storm: Puzzle.fromJson(
          (json['storm'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        racer: Puzzle.fromJson(
          (json['racer'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        streak: Puzzle.fromJson(
          (json['streak'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'chess960': chess960.toJson(),
        'atomic': atomic.toJson(),
        'racingKings': racingKings.toJson(),
        'ultraBullet': ultraBullet.toJson(),
        'blitz': blitz.toJson(),
        'kingOfTheHill': kingOfTheHill.toJson(),
        'bullet': bullet.toJson(),
        'correspondence': correspondence.toJson(),
        'horde': horde.toJson(),
        'puzzle': puzzle.toJson(),
        'classical': classical.toJson(),
        'rapid': rapid.toJson(),
        'storm': storm.toJson(),
        'racer': racer.toJson(),
        'streak': streak.toJson(),
      };
}

class TimeControl {
  int games;
  int rating;
  int rd;
  int prog;
  bool prov;

  TimeControl({
    required this.games,
    required this.rating,
    required this.rd,
    required this.prog,
    required this.prov,
  });

  factory TimeControl.fromJson(Map<String, dynamic> json) => TimeControl(
        games: (json['games'] ?? 0) as int,
        rating: (json['rating'] ?? 1500) as int,
        rd: (json['rd'] ?? 5000) as int,
        prog: (json['prog'] ?? 0) as int,
        prov: (json['prov'] ?? true) as bool,
      );

  Map<String, dynamic> toJson() => {
        'games': games,
        'rating': rating,
        'rd': rd,
        'prog': prog,
        'prov': prov,
      };
}

class Puzzle {
  int runs;
  int score;

  Puzzle({
    required this.runs,
    required this.score,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) => Puzzle(
        runs: (json['runs'] ?? 0) as int,
        score: (json['score'] ?? 0) as int,
      );

  Map<String, dynamic> toJson() => {
        'runs': runs,
        'score': score,
      };
}

class PlayTime {
  int total;
  int tv;

  PlayTime({
    required this.total,
    required this.tv,
  });

  factory PlayTime.fromJson(Map<String, dynamic> json) => PlayTime(
        total: json['total'] as int,
        tv: json['tv'] as int,
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'tv': tv,
      };
}

class Profile {
  String country;
  String location;
  String bio;
  String firstName;
  String lastName;
  int fideRating;
  int uscfRating;
  int ecfRating;
  String links;

  Profile({
    required this.country,
    required this.location,
    required this.bio,
    required this.firstName,
    required this.lastName,
    required this.fideRating,
    required this.uscfRating,
    required this.ecfRating,
    required this.links,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        country: json['country'].toString(),
        location: json['location'].toString(),
        bio: json['bio'].toString(),
        firstName: json['firstName'].toString(),
        lastName: json['lastName'].toString(),
        fideRating: (json['fideRating'] ?? 0) as int,
        uscfRating: (json['uscfRating'] ?? 0) as int,
        ecfRating: (json['ecfRating'] ?? 0) as int,
        links: json['links'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'country': country,
        'location': location,
        'bio': bio,
        'firstName': firstName,
        'lastName': lastName,
        'fideRating': fideRating,
        'uscfRating': uscfRating,
        'ecfRating': ecfRating,
        'links': links,
      };
}

class Streamer {
  Twitch twitch;
  Twitch youTube;

  Streamer({
    required this.twitch,
    required this.youTube,
  });

  factory Streamer.fromJson(Map<String, dynamic> json) => Streamer(
        twitch: Twitch.fromJson(
          (json['twitch'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
        youTube: Twitch.fromJson(
          (json['youTube'] ?? <String, dynamic>{}) as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'twitch': twitch.toJson(),
        'youTube': youTube.toJson(),
      };
}

class Twitch {
  String channel;

  Twitch({
    required this.channel,
  });

  factory Twitch.fromJson(Map<String, dynamic> json) => Twitch(
        channel: json['channel'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'channel': channel,
      };
}
