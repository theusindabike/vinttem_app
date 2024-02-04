import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/home/home.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_home');
final _shellNavigatorLastTransactionsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_last_transactions');

final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNestedNavigation(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              name: 'home',
              path: '/home',
              pageBuilder: (context, state) => NoTransitionPage(
                child: HomePage.routerBuilder(context, state),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLastTransactionsKey,
          routes: [
            GoRoute(
              name: 'last_transactions',
              path: '/last_transactions',
              pageBuilder: (context, state) => NoTransitionPage(
                child: TransactionsListPage.routerBuilder(context, state),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/transaction_create',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TransactionCreatePage(),
    ),
    GoRoute(
      path: '/transaction/:transactionId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TransactionDetailPage(),
    ),
  ],
);

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
          key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'),
        );
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavigationBar(
      body: navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vinttem'),
        elevation: 4,
      ),
      body: body,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              GoRouter.of(context).push('/transaction_create');
            },
            label: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        destinations: const [
          NavigationDestination(label: 'Home', icon: Icon(Icons.home)),
          NavigationDestination(
            label: 'Last Transactions',
            icon: Icon(Icons.history),
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
