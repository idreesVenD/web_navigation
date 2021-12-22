// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    this.id,
    this.backdropPath,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  int? id;
  String? backdropPath;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        backdropPath: json["backdrop_path"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrop_path": backdropPath,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

String data = '''[
        {
            "adult": false,
            "backdrop_path": "/VlHt27nCqOuTnuX6bku8QZapzO.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 634649,
            "original_language": "en",
            "original_title": "Spider-Man: No Way Home",
            "overview": "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
            "popularity": 24733.256,
            "poster_path": "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
            "release_date": "2021-12-15",
            "title": "Spider-Man: No Way Home",
            "video": false,
            "vote_average": 8.7,
            "vote_count": 1637
        },
        {
            "adult": false,
            "backdrop_path": "/eENEf62tMXbhyVvdcXlnQz2wcuT.jpg",
            "genre_ids": [
                878,
                28,
                12
            ],
            "id": 580489,
            "original_language": "en",
            "original_title": "Venom: Let There Be Carnage",
            "overview": "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
            "popularity": 9170.269,
            "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
            "release_date": "2021-09-30",
            "title": "Venom: Let There Be Carnage",
            "video": false,
            "vote_average": 7.2,
            "vote_count": 4816
        },
        {
            "adult": false,
            "backdrop_path": "/7ajHGIAYNMiIzejy1LJWdPrcAx8.jpg",
            "genre_ids": [
                28,
                35,
                80,
                53
            ],
            "id": 512195,
            "original_language": "en",
            "original_title": "Red Notice",
            "overview": "An Interpol-issued Red Notice is a global alert to hunt and capture the world's most wanted. But when a daring heist brings together the FBI's top profiler and two rival criminals, there's no telling what will happen.",
            "popularity": 3897.622,
            "poster_path": "/wdE6ewaKZHr62bLqCn7A2DiGShm.jpg",
            "release_date": "2021-11-04",
            "title": "Red Notice",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 2140
        },
        {
            "adult": false,
            "backdrop_path": "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 566525,
            "original_language": "en",
            "original_title": "Shang-Chi and the Legend of the Ten Rings",
            "overview": "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
            "popularity": 3514.015,
            "poster_path": "/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg",
            "release_date": "2021-09-01",
            "title": "Shang-Chi and the Legend of the Ten Rings",
            "video": false,
            "vote_average": 7.8,
            "vote_count": 4400
        },
        {
            "adult": false,
            "backdrop_path": "/tTlAA0REGPXSZPBfWyTW9ipIv1I.jpg",
            "genre_ids": [
                28,
                12,
                878,
                18
            ],
            "id": 315635,
            "original_language": "en",
            "original_title": "Spider-Man: Homecoming",
            "overview": "Following the events of Captain America: Civil War, Peter Parker, with the help of his mentor Tony Stark, tries to balance his life as an ordinary high school student in Queens, New York City, with fighting crime as his superhero alter ego Spider-Man as a new threat, the Vulture, emerges.",
            "popularity": 3450.864,
            "poster_path": "/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg",
            "release_date": "2017-07-05",
            "title": "Spider-Man: Homecoming",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 17444
        },
        {
            "adult": false,
            "backdrop_path": "/sLWUtbrpiLp23a0XDSiUiltdFPJ.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 1930,
            "original_language": "en",
            "original_title": "The Amazing Spider-Man",
            "overview": "Peter Parker is an outcast high schooler abandoned by his parents as a boy, leaving him to be raised by his Uncle Ben and Aunt May. Like most teenagers, Peter is trying to figure out who he is and how he got to be the person he is today. As Peter discovers a mysterious briefcase that belonged to his father, he begins a quest to understand his parents' disappearance – leading him directly to Oscorp and the lab of Dr. Curt Connors, his father's former partner. As Spider-Man is set on a collision course with Connors' alter ego, The Lizard, Peter will make life-altering choices to use his powers and shape his destiny to become a hero.",
            "popularity": 3059.938,
            "poster_path": "/fSbqPbqXa7ePo8bcnZYN9AHv6zA.jpg",
            "release_date": "2012-06-23",
            "title": "The Amazing Spider-Man",
            "video": false,
            "vote_average": 6.6,
            "vote_count": 13856
        },
        {
            "adult": false,
            "backdrop_path": "/1Wlwnhn5sXUIwlxpJgWszT622PS.jpg",
            "genre_ids": [
                16,
                35,
                10751
            ],
            "id": 585245,
            "original_language": "en",
            "original_title": "Clifford the Big Red Dog",
            "overview": "As Emily struggles to fit in at home and at school, she discovers a small red puppy who is destined to become her best friend. When Clifford magically undergoes one heck of a growth spurt, becomes a gigantic dog and attracts the attention of a genetics company, Emily and her Uncle Casey have to fight the forces of greed as they go on the run across New York City. Along the way, Clifford affects the lives of everyone around him and teaches Emily and her uncle the true meaning of acceptance and unconditional love.",
            "popularity": 2543.969,
            "poster_path": "/ygPTrycbMSFDc5zUpy4K5ZZtQSC.jpg",
            "release_date": "2021-11-10",
            "title": "Clifford the Big Red Dog",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 631
        },
        {
            "adult": false,
            "backdrop_path": "/sWvxBXNtCOaGdtpKNLiOqmwb10N.jpg",
            "genre_ids": [
                14,
                28
            ],
            "id": 557,
            "original_language": "en",
            "original_title": "Spider-Man",
            "overview": "After being bitten by a genetically altered spider at Oscorp, nerdy but endearing high school student Peter Parker is endowed with amazing powers to become the superhero known as Spider-Man.",
            "popularity": 2694.323,
            "poster_path": "/gSZyYEK5AfZuOFFjnVPUCLvdOD6.jpg",
            "release_date": "2002-05-01",
            "title": "Spider-Man",
            "video": false,
            "vote_average": 7.2,
            "vote_count": 14681
        },
        {
            "adult": false,
            "backdrop_path": "/ng6SSB3JhbcpKTwbPDsRwUYK8Cq.jpg",
            "genre_ids": [
                28,
                12,
                878
            ],
            "id": 429617,
            "original_language": "en",
            "original_title": "Spider-Man: Far From Home",
            "overview": "Peter Parker and his friends go on a summer trip to Europe. However, they will hardly be able to rest - Peter will have to agree to help Nick Fury uncover the mystery of creatures that cause natural disasters and destruction throughout the continent.",
            "popularity": 2571.809,
            "poster_path": "/4q2NNj4S5dG2RLF9CpXsej7yXl.jpg",
            "release_date": "2019-06-28",
            "title": "Spider-Man: Far From Home",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 11333
        },
        {
            "adult": false,
            "backdrop_path": "/5RuR7GhOI5fElADXZb0X2sr9w5n.jpg",
            "genre_ids": [
                16,
                35,
                10751,
                14
            ],
            "id": 568124,
            "original_language": "en",
            "original_title": "Encanto",
            "overview": "The tale of an extraordinary family, the Madrigals, who live hidden in the mountains of Colombia, in a magical house, in a vibrant town, in a wondrous, charmed place called an Encanto. The magic of the Encanto has blessed every child in the family with a unique gift from super strength to the power to heal—every child except one, Mirabel. But when she discovers that the magic surrounding the Encanto is in danger, Mirabel decides that she, the only ordinary Madrigal, might just be her exceptional family's last hope.",
            "popularity": 2509.615,
            "poster_path": "/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg",
            "release_date": "2021-11-24",
            "title": "Encanto",
            "video": false,
            "vote_average": 7.3,
            "vote_count": 373
        },
        {
            "adult": false,
            "backdrop_path": "/mFbS5TwN95BcSEfiztdchLgTQ0v.jpg",
            "genre_ids": [
                28,
                18,
                36
            ],
            "id": 617653,
            "original_language": "en",
            "original_title": "The Last Duel",
            "overview": "King Charles VI declares that Knight Jean de Carrouges settle his dispute with his squire, Jacques Le Gris, by challenging him to a duel.",
            "popularity": 2037.445,
            "poster_path": "/zjrJE0fpzPvX8saJXj8VNfcjBoU.jpg",
            "release_date": "2021-10-13",
            "title": "The Last Duel",
            "video": false,
            "vote_average": 7.6,
            "vote_count": 1033
        },
        {
            "adult": false,
            "backdrop_path": "/u7SeO6Y42P7VCTWLhpnL96cyOqd.jpg",
            "genre_ids": [
                28,
                12,
                14
            ],
            "id": 102382,
            "original_language": "en",
            "original_title": "The Amazing Spider-Man 2",
            "overview": "For Peter Parker, life is busy. Between taking out the bad guys as Spider-Man and spending time with the person he loves, Gwen Stacy, high school graduation cannot come quickly enough. Peter has not forgotten about the promise he made to Gwen’s father to protect her by staying away, but that is a promise he cannot keep. Things will change for Peter when a new villain, Electro, emerges, an old friend, Harry Osborn, returns, and Peter uncovers new clues about his past.",
            "popularity": 2182.226,
            "poster_path": "/c3e9e18SSlvFd1cQaGmUj5tqL5P.jpg",
            "release_date": "2014-04-16",
            "title": "The Amazing Spider-Man 2",
            "video": false,
            "vote_average": 6.4,
            "vote_count": 10129
        },
        {
            "adult": false,
            "backdrop_path": "/xGrTm3J0FTafmuQ85vF7ZCw94x6.jpg",
            "genre_ids": [
                18,
                36,
                12
            ],
            "id": 589761,
            "original_language": "ru",
            "original_title": "Чернобыль",
            "overview": "The aftermath of a shocking explosion at the Chernobyl nuclear power station made hundreds of people sacrifice their lives to clean up the site of the catastrophe and to successfully prevent an even bigger disaster that could have turned a large part of the European continent into an uninhabitable exclusion zone. This is their story.",
            "popularity": 1955.304,
            "poster_path": "/kfQJQWFEoWRVBH8FUKnT0HX1yRS.jpg",
            "release_date": "2021-04-15",
            "title": "Chernobyl: Abyss",
            "video": false,
            "vote_average": 6.3,
            "vote_count": 241
        },
        {
            "adult": false,
            "backdrop_path": "/6MQmtWk4cFwSDyNvIgoJRBIHUT3.jpg",
            "genre_ids": [
                14,
                28,
                12
            ],
            "id": 559,
            "original_language": "en",
            "original_title": "Spider-Man 3",
            "overview": "The seemingly invincible Spider-Man goes up against an all-new crop of villains—including the shape-shifting Sandman. While Spider-Man’s superpowers are altered by an alien organism, his alter ego, Peter Parker, deals with nemesis Eddie Brock and also gets caught up in a love triangle.",
            "popularity": 2005.518,
            "poster_path": "/2jLxKF73SAPkyhIWrnv67IH7kJ1.jpg",
            "release_date": "2007-05-01",
            "title": "Spider-Man 3",
            "video": false,
            "vote_average": 6.3,
            "vote_count": 10781
        },
        {
            "adult": false,
            "backdrop_path": "/lyvszvJJqqI8aqBJ70XzdCNoK0y.jpg",
            "genre_ids": [
                28,
                12,
                14,
                878
            ],
            "id": 524434,
            "original_language": "en",
            "original_title": "Eternals",
            "overview": "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
            "popularity": 1876.143,
            "poster_path": "/uaEIEIw9Y7DsvbWWMbG9ySjNF73.jpg",
            "release_date": "2021-11-03",
            "title": "Eternals",
            "video": false,
            "vote_average": 7.1,
            "vote_count": 1466
        },
        {
            "adult": false,
            "backdrop_path": "/gBEyQ56m92x0sbz3QXwjfsvLPBz.jpg",
            "genre_ids": [
                16,
                878,
                10751,
                35
            ],
            "id": 482321,
            "original_language": "en",
            "original_title": "Ron's Gone Wrong",
            "overview": "In a world where walking, talking, digitally connected bots have become children's best friends, an 11-year-old finds that his robot buddy doesn't quite work the same as the others do.",
            "popularity": 1645.378,
            "poster_path": "/gA9QxSravC2EVEkEKgyEmDrfL0e.jpg",
            "release_date": "2021-10-15",
            "title": "Ron's Gone Wrong",
            "video": false,
            "vote_average": 8.4,
            "vote_count": 436
        },
        {
            "adult": false,
            "backdrop_path": "/5RMqFZdefnDwY7rdD1oJcTkWPdF.jpg",
            "genre_ids": [
                16,
                35,
                10751
            ],
            "id": 774741,
            "original_language": "en",
            "original_title": "Diary of a Wimpy Kid",
            "overview": "Greg Heffley is a scrawny but ambitious kid with an active imagination and big plans to be rich and famous – he just has to survive middle school first.",
            "popularity": 1654.102,
            "poster_path": "/obg6lWuNaZkoSlwrVG4VVk4SmT.jpg",
            "release_date": "2021-12-03",
            "title": "Diary of a Wimpy Kid",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 93
        },
        {
            "adult": false,
            "backdrop_path": "/r2GAjd4rNOHJh6i6Y0FntmYuPQW.jpg",
            "genre_ids": [
                12,
                28,
                53
            ],
            "id": 370172,
            "original_language": "en",
            "original_title": "No Time to Die",
            "overview": "Bond has left active service and is enjoying a tranquil life in Jamaica. His peace is short-lived when his old friend Felix Leiter from the CIA turns up asking for help. The mission to rescue a kidnapped scientist turns out to be far more treacherous than expected, leading Bond onto the trail of a mysterious villain armed with dangerous new technology.",
            "popularity": 1456.678,
            "poster_path": "/iUgygt3fscRoKWCV1d0C7FbM9TP.jpg",
            "release_date": "2021-09-29",
            "title": "No Time to Die",
            "video": false,
            "vote_average": 7.5,
            "vote_count": 2645
        },
        {
            "adult": false,
            "backdrop_path": "/upOi9aVqPPky7Ba4GsiyFdjc82I.jpg",
            "genre_ids": [
                37,
                28,
                53
            ],
            "id": 887767,
            "original_language": "en",
            "original_title": "Last Shoot Out",
            "overview": "Soon after a newlywed learns that her husband had her father shot down, she flees from the Callahan ranch in fear. She's rescued by a gunman who safeguards her at a remote outpost as he staves off her husband's attempts to reclaim his bride.",
            "popularity": 1438.22,
            "poster_path": "/pvEtPxotI3POlVPvNxgrHJuDXfe.jpg",
            "release_date": "2021-12-03",
            "title": "Last Shoot Out",
            "video": false,
            "vote_average": 6.7,
            "vote_count": 41
        },
        {
            "adult": false,
            "backdrop_path": "/kJ2srEZSlmGfAqLKGVMPhBDdr1G.jpg",
            "genre_ids": [
                10770,
                53,
                80
            ],
            "id": 831223,
            "original_language": "en",
            "original_title": "Gone Mom: The Disappearance of Jennifer Dulos",
            "overview": "Jennifer Dulos, the wealthy, Connecticut mother-of-five who mysteriously vanished.",
            "popularity": 1482.054,
            "poster_path": "/mzTNGnLG6LTHmrqrY0IADHDuyOJ.jpg",
            "release_date": "2021-06-05",
            "title": "Gone Mom: The Disappearance of Jennifer Dulos",
            "video": false,
            "vote_average": 4.8,
            "vote_count": 4
        }
    ]''';
