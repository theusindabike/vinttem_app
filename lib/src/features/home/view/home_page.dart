import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  factory HomePage.routerBuilder(_, __) {
    return const HomePage(key: Key('home_page'));
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.black87,
    );
  }
}
