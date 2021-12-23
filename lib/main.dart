import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web_navigation/data.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

List<Movie> movies = movieFromJson(data);

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
          child: Wrap(
            children: List.generate(
              movies.length,
              (index) => Padding(
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
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  final backgroundGradient = const BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: backgroundGradient,
        ),
        BackDropImage(
          image: movies[0].backdropPath!,
        ),
        TitleSubtitle(
          controller: controller,
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
  }) : super(key: key);

  final PageController controller;

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
              child: Text(
                'Spider-Man:\nNo Way Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 5 * SizeConfig.blockSizeVertical!,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Material(
                      elevation: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: (index == 0)
                              ? Border.all(color: Colors.black, width: 5.0)
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
