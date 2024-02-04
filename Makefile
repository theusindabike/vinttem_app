run:
	fvm flutter run --flavor development --target lib/main_development.dart

run_staging:
	fvm flutter run --flavor staging --target lib/main_staging.dart

clean:
	fvm exec melos run clean

get:
	fvm exec melos run get

build_runner:
	fvm exec melos run build_runner

qualitycheck:
	fvm exec melos run qualitycheck

tests:
	fvm exec melos run test

generate_coverage:
	fvm exec melos run generate_coverage

lint:
	fvm exec melos run lint

format:
	fvm exec melos run format

githubactions_build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs