import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/home/view/view.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_app/src/features/transactions/transaction_form/view/new_transaction_page.dart';
import 'package:vinttem_app/src/l10n/l10n.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class App extends StatelessWidget {
  const App({required VinttemRepository vinttemRepository, super.key})
      : _vinttemRepository = vinttemRepository;

  final VinttemRepository _vinttemRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _vinttemRepository,
      child: BlocProvider<TransactionsListBloc>(
        create: (context) => TransactionsListBloc(
          vinttemRepository: _vinttemRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/transactions',
        builder: (context, state) => const TransactionDetailPage(),
      ),
      GoRoute(
        path: '/new_transaction',
        builder: (context, state) => const NewTransactionPage(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.indigoM3,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.indigoM3),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
