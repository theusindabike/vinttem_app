# Vinttem

This simplifies financial life

---

## To Run

Using Flutter CLI:
```sh
# Get dependencies
$ flutter pub get

# Build runner
$ flutter pub run build_runner build --delete-conflicting-outputs

# Flutter run development flavor
$ flutter run --flavor development --target lib/main_development.dart
```

Using Makefile + [fvm](https://fvm.app/):
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

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

Using Makefile + [fvm](https://fvm.app/):
```sh
# Without coverage output
$ make tests

# With coverage output
$ make coverage_tests
```
---
