class PercentageCalculator {
  PercentageCalculator({
    required this.wins,
    required this.draws,
    required this.losses,
  }) {
    calculatePercentages();
  }

  final int wins;
  final int draws;
  final int losses;

  double winPercentage = 0;
  double drawPercentage = 0;
  double lossPercentage = 0;

  void calculatePercentages() {
    final games = wins + draws + losses;

    winPercentage = 100 * wins / games;
    drawPercentage = 100 * draws / games;
    lossPercentage = 100 * losses / games;

    final fractionalPart = <String, double>{
      'Wins': winPercentage - winPercentage.floor(),
      'Draws': drawPercentage - drawPercentage.floor(),
      'Losses': lossPercentage - lossPercentage.floor(),
    };

    winPercentage -= fractionalPart['Wins']!;
    drawPercentage -= fractionalPart['Draws']!;
    lossPercentage -= fractionalPart['Losses']!;

    final largestRemainder = Map.fromEntries(
      fractionalPart.entries.toList()
        ..sort((b, a) => a.value.compareTo(b.value)),
    );

    var offset =
        100 - (winPercentage + drawPercentage + lossPercentage).toInt();

    var index = 0;
    while (offset-- != 0) {
      final key = largestRemainder.keys.elementAt(index++);

      switch (key) {
        case 'Wins':
          winPercentage++;
        case 'Draws':
          drawPercentage++;
        case 'Losses':
          lossPercentage++;
      }
    }
  }
}
