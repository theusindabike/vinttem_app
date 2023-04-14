import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_api/vinttem_api.dart';
import 'package:vinttem_app/home/view/view.dart';
import 'package:vinttem_app/l10n/l10n.dart';
import 'package:vinttem_app/transactions/transaction.dart';

class App extends StatelessWidget {
  App({super.key});

  final _transactionRepository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _transactionRepository,
      child: BlocProvider(
        create: (_) =>
            TransactionsListBloc(transactionRepository: _transactionRepository),
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
        builder: (context, state) => const TransactionPage(),
      ),
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
