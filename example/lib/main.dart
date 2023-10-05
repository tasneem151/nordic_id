import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nordic_id/nordic_id.dart';
import 'package:nordic_id/tag_epc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  //final _nordicIdPlugin = NordicId();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await NordicId.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    NordicId.connectionStatusStream.receiveBroadcastStream().listen(updateConnection);
    NordicId.tagsStatusStream.receiveBroadcastStream().listen(updateTags);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  List<TagEpc> _data = [];
  void updateTags(dynamic result) {
    //log('update tags');
    setState(() {
      _data = TagEpc.parseTags(result);

      _data.add(result);
    });
  }

  bool isConnectedStatus = false;

  void updateConnection(dynamic result) {
    setState(() {
      isConnectedStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nordic ID Plugin example'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blueAccent,
                child: const Text(
                  'Initialize',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await NordicId.initialize;
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blueAccent,
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await NordicId.connect;
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blueAccent,
                child: const Text(
                  'Refresh Trace',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await NordicId.refreshTracing;
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blueAccent,
                child: const Text(
                  'Stop Trace',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await NordicId.stopTrace;
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blueAccent,
                child: const Text(
                  'Is Connected',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  bool? isConnected = await NordicId.isConnected;
                  setState(() {
                    isConnectedStatus = isConnected ?? false;
                  });
                },
              ),
              Text(
                'Nordic Reader isConnected:$isConnectedStatus',
                style: TextStyle(color: Colors.blue.shade800, fontSize: 18),
              ),
              ..._data.map(
                (TagEpc tag) => Card(
                  color: Colors.blue.shade50,
                  child: Container(
                    width: 330,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tag EPC:${tag.epc} RSSI:${tag.rssi}',
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
