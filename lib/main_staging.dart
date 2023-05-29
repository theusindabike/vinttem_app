import 'package:vinttem_app/app/app.dart';
import 'package:vinttem_app/bootstrap.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  bootstrap(
    () => App(vinttemRepository: VinttemFastAPIRespository()),
  );
}
