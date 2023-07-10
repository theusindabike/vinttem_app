import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/historic/historic.dart';
import 'package:vinttem_app/src/features/home/home.dart';
import 'package:vinttem_app/src/features/transactions/transactions_list/transactions_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  factory HomePage.routerBuilder(_, __) {
    return const HomePage(key: Key('home_page'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vinttem'),
        elevation: 4,
      ),
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          TransactionsListPage(),
          LastTransactionsPage(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              context.push('/transaction_create');
            },
            label: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          context.read<HomeCubit>().setTab(HomeTab.historic);
        },
        selectedIndex: selectedTab.index,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Historic',
          ),
        ],
      ),
    );
  }
}
