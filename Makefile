run:
	fvm flutter run --flavor development --target lib/main_development.dart

run_staging:
	fvm flutter run --flavor staging --target lib/main_staging.dart

clean:
	melos run clean

get:
	melos run get

build_runner:
	melos run build_runner

qualitycheck:
	melos run qualitycheck

tests:
	melos run test

generate_coverage:
	melos run generate_coverage

lint:
	melos run lint

format:
	melos run format