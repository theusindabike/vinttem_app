import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';
import 'package:vinttem_app/src/l10n/l10n.dart';
import 'package:vinttem_app/src/routing/app_router.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class App extends StatelessWidget {
  const App({required VinttemRepository vinttemRepository, super.key})
      : _vinttemRepository = vinttemRepository;

  final VinttemRepository _vinttemRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _vinttemRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TransactionsListBloc>(
            create: (context) => TransactionsListBloc(
              vinttemRepository: _vinttemRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
