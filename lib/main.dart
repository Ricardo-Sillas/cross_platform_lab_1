import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
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
      home: const MyHomePage(title: 'Bitcoin Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String bitcoinInfo = '';

  void initState() {
    _getInformation();
    super.initState();
  }

  void _getInformation() async {
    var url = Uri.https('api.coindesk.com', '/v1/bpi/currentprice.json');
    var response = await http.get(url);
    var decoded = json.decode(response.body);

    bitcoinInfo = 'Price: \$${decoded['bpi']['USD']['rate']}';
    setState(() {
      bitcoinInfo;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$bitcoinInfo',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 25),
            FloatingActionButton(
              onPressed: _getInformation,
              tooltip: 'Increment',
              child: const Icon(Icons.attach_money_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
