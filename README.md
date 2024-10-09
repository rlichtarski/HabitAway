# HabitAway - a mobile Flutter app to overcome bad habits!

![coverage][coverage_badge]
[![analysis: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

## Table of contents
* [Main goal of this project](#main-goal-of-this-project)
* [Tech stack and libraries used in this app](#tech-stack-and-libraries-used-in-this-app)
* [Getting Started](#getting-started)
* [Running Tests](#running-tests)

---

## Main goal of this project

As most of us know, many people struggle with bad habits they wish to break. Especially in today's world, habits like endlessly scrolling through social media have become more common and harder to overcome. 

This project's goal is to help users take control of their habits by tracking streaks of their progress in avoiding these behaviors. [Research](https://www.earth.com/news/streaks-can-be-a-powerful-tool-for-motivation/) shows that when we build a streak of success (as seen in popular apps like [Duolingo](https://www.duolingo.com/) with their daily language streaks), we are less likely to break it. By keeping track of the days users go without their bad habits, this project helps them build momentum and stay motivated to keep going.

---

## Tech stack and libraries used in this app
- [Very Good CLI][very_good_cli_link] - A Command-Line Interface to generate scalable templates and use helpful commands. Used in this project for generating the starter Flutter app template (`very_good create flutter_app`) with some cool built-in features, like build flavors (development and production flavors are used in this project) 

---

## Getting Started

If you don't have Very Good Command Line Interface installed, run the following command: `dart pub global activate very_good_cli`

#### This project contains 2 flavors:

- development
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

---

#### [Firebase configuration](docs/firebase-configuration.md) - this requires some additional steps, so I moved Firebase configuration set up to another page 
#### [Google Sign-In configuration with Firebase](docs/google-sign-in-configuration.md) - this also requires some additional steps, so I moved Google Sign-In configuration set up to another page 

---

## Running Tests

To run all unit and widget tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
