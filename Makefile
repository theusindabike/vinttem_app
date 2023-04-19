run:
	fvm flutter run --flavor development --target lib/main_development.dart

clean:
	fvm flutter clean

get:
	fvm flutter pub get

build_runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

prebuild:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter pub run build_runner build --delete-conflicting-outputs

tests:
	fvm flutter test --coverage --test-randomize-ordering-seed random

coverage_tests:
	fvm flutter test --coverage --test-randomize-ordering-seed random
	lcov --remove coverage/lcov.info 'lib/**/*.g.dart' -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/
	open coverage/index.html

lint:
	fvm flutter analyze lib test packages

githubactions_build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs