import 'package:flutter/material.dart';
import 'package:learn_dio/dummy_json.dart';
import 'package:learn_dio/json_placeholder.dart';
import 'package:learn_dio/mockapi.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Dio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            tabAlignment: TabAlignment.center,
            tabs: [
              Text("DummyJson", style: TextStyle(color: Colors.white)),
              Text("MockApi", style: TextStyle(color: Colors.white)),
              Text("JsonPlaceholder", style: TextStyle(color: Colors.white))
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DummyJson(),
            MockApi(),
            JsonPlaceholder()
          ],
        ),
      ),
    );
  }
}
