![codecov][codecov_badge]

# Vinttem

A new way of tracking expenses that considers how much each person earns.

## Stack 👨‍💻
- [Flutter](https://docs.flutter.dev/release/release-notes) 3.10.1
- [FVM](https://fvm.app/) (flutter version manager)
- [Melos](https://melos.invertase.dev/) (multi-package manager)

## Backend 🖥️
Check [vinttem-fastapi](https://github.com/theusindabike/vinttem-fastapi) repo for more information.

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

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

---

## Tips 🗣️
Check [Makefile](Makefile) and [melos.yaml](melos.yaml) for usefull commands.





[codecov_badge]: https://codecov.io/gh/theusindabike/vinttem_app/branch/main/graph/badge.svg?token=FEAR98ITPB