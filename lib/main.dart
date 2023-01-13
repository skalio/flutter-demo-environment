import 'package:environment_demo/environment.dart';
import 'package:environment_demo/testBanner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Environment Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // The TestBanner shows a ribbon stating that you are running in test mode.
        // In production mode it is not visible.
        home: const TestBanner(
          child: MyHomePage(title: 'Environment Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _value = "";

  void _fetchFromBackend() async {
    // backend hostname ist dependent on the environment you chose when building
    http.Response response =
        await http.get(Uri.parse("https://${Environment.backendHostname}"));
    Map map = jsonDecode(response.body) as Map;
    setState(() {
      _value = map.values.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Text(
            '$_value',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchFromBackend,
        tooltip: 'fetch from backend',
        child: const Icon(Icons.add),
      ),
    );
  }
}
