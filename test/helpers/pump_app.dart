import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinttem_api/vinttem_api.dart';
import 'package:vinttem_app/l10n/l10n.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    TransactionRepository? transactionRepository,
  }) {
    return pumpWidget(
      RepositoryProvider(
        create: (context) =>
            transactionRepository ?? MockTransactionRepository(),
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
    TransactionRepository? transactionRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      transactionRepository: transactionRepository,
    );
  }
}
