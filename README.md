# Vinttem

A new way of tracking expenses that considers how much each person earns.

## Stack
- [Flutter](https://docs.flutter.dev/release/release-notes) 3.7.9
- [FVM](https://fvm.app/) (flutter version manager)
- [Melos](https://melos.invertase.dev/) (multi-package manager)
- [Bloc](https://bloclibrary.dev/) (as state manager)

## First Run

Using Flutter CLI:
```sh
# Get dependencies
$ flutter pub get

# Build runner
$ flutter pub run build_runner build --delete-conflicting-outputs

# Flutter run development flavor
$ flutter run --flavor development --target lib/main_development.dart
```

Using Melos + Fvm:
```sh
# Get dependencies
$ melos run get

# Build runner
$ melos run build_runner

# Flutter run development flavor
$ fvm flutter run --flavor development --target lib/main_development.dart
```

Using Makefile + Fvm:
```sh
# Get dependencies
$ make prebuild

# Build runner
$ make build_runner

# Flutter run development flavor
$ make run
```
---

## Running Tests

Using Flutter CLI
```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

Using Melos + Fvm:
```sh
$ melos run tests

# Generate coverage output
$ melos run generate_coverage
```

Using Makefile + Fvm:
```sh
$ make tests

# Generate coverage output
$ make generate_coverage
```
---

## Build Runner
Using Makefile + Fvm:
```sh
$ make build_runner
```
---