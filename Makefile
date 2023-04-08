run:
	fvm flutter run --flavor development --target lib/main_development.dart

prebuild:
	fvm flutter pub get

tests:
	fvm flutter test --coverage --test-randomize-ordering-seed random

coverage_tests:
	fvm flutter test --coverage --test-randomize-ordering-seed random
	genhtml coverage/lcov.info -o coverage/
	open coverage/index.html

build_runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

githubactions_build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs