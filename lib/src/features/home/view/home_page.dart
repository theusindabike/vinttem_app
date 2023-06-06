import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/transactions/transactions_list/transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vinttem'),
        elevation: 4,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      body: <Widget>[
        const TransactionsListPage(),
        Container(
          color: Colors.white60,
          alignment: Alignment.center,
          child: const Text('Container 2'),
        ),
      ][currentPageIndex],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              context.push('/transactions');
            },
            elevation: 4,
            label: const Icon(Icons.add),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              context.push('/new_transaction');
            },
            elevation: 4,
            label: const Icon(Icons.alarm_add),
          ),
        ],
      ),
    );
  }
}
