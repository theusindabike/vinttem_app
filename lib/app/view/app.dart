import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vinttem_app/home/view/view.dart';
import 'package:vinttem_app/l10n/l10n.dart';
import 'package:vinttem_app/transactions/transaction.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class App extends StatelessWidget {
  // const App({required VinttemRepository vinttemRepository, super.key})
  // : _vinttemRepository = vinttemRepository;
  App({super.key});

  // final _vinttemRepository = MockTransactionRepository();
  final _vinttemRepository = VinttemFastAPIRespository();

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
