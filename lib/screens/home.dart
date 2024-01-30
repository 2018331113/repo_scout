import 'package:flutter/material.dart';

import '../api/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Api().getRepositories({
      "q": "topic:Flutter",
      "sort": "stars",
      "order": "desc",
      "page": 1,
      "per_page": 10,
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      )
    );
  }
}