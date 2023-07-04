import 'package:network_client/network_client.dart';
import 'package:vinttem_app/bootstrap.dart';
import 'package:vinttem_app/src/app.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  final networkClient = NetworkClient(baseUrl: 'http://10.0.2.2:8000');

  bootstrap(
    () => App(
      vinttemRepository: VinttemFastAPIRepository(networkClient: networkClient),
    ),
  );
}
