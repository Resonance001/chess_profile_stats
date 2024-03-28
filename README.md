# ♟️ Chess Profile & Stats

An adaptive and responsive application that showcases your [Lichess.org](https://www.lichess.org) profile

# Time Control

The application only considers ``` bullet ```, ``` blitz ```, and ``` rapid ```.

The rest of the time control and/or game modes are not considered: ``` classical ```, ``` correspondence ```, ``` chess960 ```, ``` king of the hill ```, ``` three-check ```, ``` antichess ```, ``` atomic ```, ```` horde ````, ``` racing kings ```, ``` crazyhouse ``` and ``` ultrabullet ```.

[{"name":"Bullet","points":[[2017,2,22,1394]]},{"name":"Blitz","points":[]},{"name":"Rapid","points":[]},{"name":"Classical","points":[]},{"name":"Correspondence","points":[]},{"name":"Chess960","points":[]},{"name":"King of the Hill","points":[]},{"name":"Three-check","points":[]},{"name":"Antichess","points":[]},{"name":"Atomic","points":[]},{"name":"Horde","points":[]},{"name":"Racing Kings","points":[]},{"name":"Crazyhouse","points":[]},{"name":"Puzzles","points":[]},{"name":"UltraBullet","points":[]}]

# API Endpoints

All requests go to ``` https://lichess.org ``` [^1]

#### User Data
```
api/user/{username}
```

#### Rating History
```
api/user/{username}/rating-history
```

#### Performance Statistics
```
api/user/{username}/perf/bullet
api/user/{username}/perf/blitz
api/user/{username}/perf/rapid
```

[^1]: [Lichess API Endpoint](https://lichess.org/api#section/Introduction/Endpoint)

# Credits

Assets (images) used in the application were taken from [Lichess Public Assets](https://github.com/lichess-org/lila/tree/master/public/images).



