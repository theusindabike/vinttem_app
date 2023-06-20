import 'package:go_router/go_router.dart';
import 'package:vinttem_app/src/features/home/home.dart';
import 'package:vinttem_app/src/features/transactions/transaction.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/transaction_create',
      builder: (context, state) => const TransactionCreatePage(),
    )
  ],
);
