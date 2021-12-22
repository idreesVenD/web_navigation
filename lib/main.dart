import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
              final PageController controller = PageController();
              const backgroundGradient = BoxDecoration(
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
              return Scaffold(
                body: PageView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          decoration: backgroundGradient,
                        ),
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0, 0.6],
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w1280/VlHt27nCqOuTnuX6bku8QZapzO.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const TitleSubtitle(),
                      ],
                    ),
                    Container(
                      color: const Color(0xff1F0C3F),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(index.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spider-Man:\nNo Way Home',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 5 * SizeConfig.blockSizeVertical!,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 2 * SizeConfig.blockSizeVertical!,
              ),
            ),
            // SizedBox(
            //   height: 300.0,
            // ),
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
