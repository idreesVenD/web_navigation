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
              return Scaffold(
                body: PageView(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0, 0),
                          colors: [
                            Color(0xff2A2068),
                            Color(0xff110C31).withOpacity(.97),
                          ],
                          radius: 0.8,
                        ),
                      ),
                      child: const Center(
                        child: Text('First Page'),
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(index.toString()),
                        );
                      },
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
