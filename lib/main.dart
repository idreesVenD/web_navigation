import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'
    as a;
import 'package:url_strategy/url_strategy.dart';
import 'package:web_navigation/data.dart';
import 'package:http/http.dart' as http;

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

List<Movie> movies = movieFromJson(data);

BoxDecoration backgroundGradient = const BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xff322043),
      Color(0xff1F0C3F),
    ],
    stops: [0.0, 1.0],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
    tileMode: TileMode.repeated,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: const Color(0xff322043),
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        final settingsUri = Uri.parse(settings.name ?? "/");

        if (settingsUri.path == "/") {
          int? counter =
              int.tryParse(settingsUri.queryParameters["counter"] ?? "");
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => MyHomePage(
              title: 'Flutter Demo Home Page',
              counter: counter,
            ),
          );
        }
        if (settingsUri.path == "/home") {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return HomeScreen();
            },
          );
        }
        if (settingsUri.path == "/detail") {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return DetailScreen();
            },
          );
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 3 * SizeConfig.blockSizeHorizontal!,
            ),
            const LogoWidget(),
          ],
        ),
        actions: [
          Builder(builder: (context) {
            return CartButton(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
          SizedBox(
            width: 3 * SizeConfig.blockSizeHorizontal!,
          ),
        ],
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          HomeBanner(
            controller: controller,
          ),
          const MovieGrid(),
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  const CartButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "1",
            style: TextStyle(fontSize: 10.0),
          ),
          SizedBox(
            width: 2.0,
          ),
          Icon(
            Icons.shopping_cart_rounded,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.movie),
        SizedBox(
          width: 8.0,
        ),
        Text("MovieLOO"),
      ],
    );
  }
}

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1F0C3F),
      child: Center(
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Wrap(
              children: List.generate(
                movies.length,
                (index) => AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 300),
                  child: SlideAnimation(
                    child: a.FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/" +
                              movies[index].posterPath!,
                          width: 250.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeBanner extends StatefulWidget {
  const HomeBanner({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int selectedIndex = 0;

  final GlobalKey<AnimatorWidgetState> _title =
      GlobalKey<AnimatorWidgetState>();
  final GlobalKey<AnimatorWidgetState> _overview =
      GlobalKey<AnimatorWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: backgroundGradient,
        ),
        BackDropImage(
          image: movies[selectedIndex].backdropPath!,
        ),
        TitleSubtitle(
          selectedIndex: selectedIndex,
          controller: widget.controller,
          onIndexChange: (index) {
            if (index != selectedIndex) {
              _title.currentState?.forward();
              setState(() {
                selectedIndex = index;
              });
            }
          },
          titleKey: _title,
          overviewKey: _overview,
        ),
      ],
    );
  }
}

class BackDropImage extends StatelessWidget {
  const BackDropImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: _shaderGradient,
      blendMode: BlendMode.dstIn,
      child: Align(
        alignment: Alignment.centerRight,
        child: _buildImage(context),
      ),
    );
  }

  SizedBox _buildImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width *
          (MediaQuery.of(context).size.width < 1450
              ? 1
              : (MediaQuery.of(context).size.width < 1650 ? 0.9 : 0.8)),
      height: MediaQuery.of(context).size.height,
      child: Image.network(
        "https://image.tmdb.org/t/p/w1280/$image",
        fit: BoxFit.cover,
      ),
    );
  }

  Shader _shaderGradient(rect) {
    return const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0, 0.6],
      colors: [Colors.black, Colors.transparent],
    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
  }
}

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({
    Key? key,
    required this.controller,
    required this.onIndexChange,
    required this.selectedIndex,
    required this.titleKey,
    required this.overviewKey,
  }) : super(key: key);

  final PageController controller;
  final Function(int index) onIndexChange;
  final int selectedIndex;
  final GlobalKey<AnimatorWidgetState> titleKey;
  final GlobalKey<AnimatorWidgetState> overviewKey;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 3 * SizeConfig.blockSizeVertical!,
        left: 4 * SizeConfig.blockSizeHorizontal!,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).size.width < 1450
                      ? 0.8
                      : (MediaQuery.of(context).size.width < 1650 ? 0.4 : 0.3)),
              child: FadeInUp(
                key: titleKey,
                child: Text(
                  movies[selectedIndex].title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 5 * SizeConfig.blockSizeVertical!,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  (MediaQuery.of(context).size.width < 1450
                      ? 0.8
                      : (MediaQuery.of(context).size.width < 1650 ? 0.4 : 0.3)),
              child: Text(
                movies[selectedIndex].overview!,
                maxLines: 6,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 1.6 * SizeConfig.blockSizeVertical!,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("RENT NOW"),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: AnimationLimiter(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: a.SlideAnimation(
                          verticalOffset: 0.0,
                          horizontalOffset: index * 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                onIndexChange(index);
                              },
                              child: Material(
                                elevation: 5.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: (index == selectedIndex)
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 5.0,
                                          )
                                        : null,
                                  ),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/${movies[index].backdropPath}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    this.counter,
  }) : super(key: key);

  final String title;
  final int? counter;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _counter = widget.counter ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({
    Key? key,
  }) : super(key: key);

  final PageController controller = PageController();

  var url = Uri.parse(
      'https://api.themoviedb.org/3/movie/634649/credits?api_key=2e3196b2667f3f54ded1d98d15b5020d');

  Future<http.Response> fetchAlbum() {
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var movie = movies[0];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 3 * SizeConfig.blockSizeHorizontal!,
            ),
            const LogoWidget(),
          ],
        ),
        actions: [
          Builder(builder: (context) {
            return CartButton(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
          SizedBox(
            width: 3 * SizeConfig.blockSizeHorizontal!,
          ),
        ],
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: backgroundGradient,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 78.0,
              left: 48.0,
              right: 48.0,
              bottom: 48.0,
            ),
            child: Material(
              elevation: 6.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xff361F41),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w780/${movie.posterPath}",
                      ),
                      const SizedBox(
                        width: 32.0,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  movie.title!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 5 * SizeConfig.blockSizeVertical!,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                  label: const Text("RENT NOW FOR 99 Rs."),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Action",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          2.2 * SizeConfig.blockSizeVertical!,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          2.2 * SizeConfig.blockSizeVertical!,
                                      width: 2.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Comedy",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          2.2 * SizeConfig.blockSizeVertical!,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          2.2 * SizeConfig.blockSizeVertical!,
                                      width: 2.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Drama",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      fontSize:
                                          2.2 * SizeConfig.blockSizeVertical!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                movie.overview!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 2 * SizeConfig.blockSizeVertical!,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Viewer Rating:",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                        1.8 * SizeConfig.blockSizeVertical!,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      value: movie.voteAverage! / 10,
                                    ),
                                    Text(
                                      (movie.voteAverage!).toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              "Cast",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 2.2 * SizeConfig.blockSizeVertical!,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Expanded(
                              flex: 7,
                              child: FutureBuilder<http.Response>(
                                future: fetchAlbum(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data =
                                        jsonDecode(snapshot.data!.body)["cast"];
                                    return SingleChildScrollView(
                                      child: Wrap(
                                        children: List.generate(
                                          12,
                                          (index) => Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 16.0,
                                              right: 16.0,
                                            ),
                                            child: Material(
                                              elevation: 5.0,
                                              child: Image.network(
                                                "https://image.tmdb.org/t/p/w185${data[index]['profile_path']}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}
