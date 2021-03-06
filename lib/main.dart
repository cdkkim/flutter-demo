import 'package:animations/animations.dart';
import 'package:flutter_demo/animated_search_bar/animated_search_bar.dart';
import 'package:flutter_demo/bubble_loading/bubble_loading_app.dart';
import 'package:flutter_demo/message_animation/message_animation_app.dart';
import 'package:flutter_demo/music_app/music_app.dart';
import 'package:flutter_demo/reflectly/reflectly_app.dart';
import 'package:flutter_demo/shink_top_list/shrink_top_list_app.dart';
import 'package:flutter_demo/sushi_app/sushi_app.dart';
import 'package:flutter_demo/things/things_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // pageTransitionsTheme: PageTransitionsTheme(
        //   builders: {
        //     TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
        //       transitionType: SharedAxisTransitionType.horizontal,
        //     )
        //   }
        // ),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const MyHomePage(title: 'Applications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SushiApp(),
                  ));
                },
                child: Text('sushi app'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MessageAnimationApp(),
                  ));
                },
                child: Text('Messages animation'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShrinkTopListApp(),
                  ));
                },
                child: Text('shrink top list'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BubbleLoadingApp(),
                  ));
                },
                child: Text('bubble loading'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MusicApp(),
                  ));
                },
                child: Text('music app'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimatedSearchBar(),
                  ));
                },
                child: Text('Animated search bar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReflectlyApp(),
                  ));
                },
                child: Text('Reflectly'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ThingsApp(),
                  ));
                },
                child: Text('Things'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
