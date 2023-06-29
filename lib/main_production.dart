import 'package:network_client/network_client.dart';
import 'package:vinttem_app/bootstrap.dart';
import 'package:vinttem_app/src/app.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  final networkClient = NetworkClient(baseUrl: 'https://vinttem.com');

  bootstrap(
    () => App(
      vinttemRepository: VinttemFastAPIRepository(networkClient: networkClient),
    ),
  );
}
