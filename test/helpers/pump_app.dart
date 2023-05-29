import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_app/l10n/l10n.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

class MockTransactionRepository extends Mock implements VinttemRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    VinttemRepository? vinttemRepository,
  }) {
    return pumpWidget(
      RepositoryProvider(
        create: (context) =>
            vinttemRepository ?? MockTransactionRepository(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: widget),
        ),
      ),
    );
  }

  Future<void> pumpRoute(
    Route<dynamic> route, {
    VinttemRepository? transactionRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      vinttemRepository: transactionRepository,
    );
  }
}
