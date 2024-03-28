# ♟️ Chess Profile & Stats

[^1]: [Lichess API Endpoint](https://lichess.org/api#section/Introduction/Endpoint)

An adaptive and responsive application that showcases your [Lichess.org](https://www.lichess.org) profile

# Time Control and Game Modes

The application only considers ``` bullet ```, ``` blitz ```, and ``` rapid ```.

> Ignores less common time controls such as ``` classical ```, ``` correspondence ```, and ``` ultrabullet```.

> Ignores variants such as ``` antichess ```, ``` atomic ```, ``` chess960 ```, ``` crazyhouse ```,```` horde ````, ``` king of the hill ```, ``` racing kings ``` and ``` three-check ```.

# API Endpoints

All requests go to ``` https://lichess.org ``` [^1]

#### User Data
```
https://lichess.org/api/user/{username}
```

#### Rating History
```
https://lichess.org/api/user/{username}/rating-history
```

#### Performance Statistics
```
https://lichess.org/api/user/{username}/perf/{perfType}
```

# Credits

Assets (images) used in the application were taken from [Lichess Public Assets](https://github.com/lichess-org/lila/tree/master/public/images).



