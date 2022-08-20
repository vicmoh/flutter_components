# About

A library containing multiple flutter components to build
Flutter project.

# Installation

## Provider skeleton package

You'll need `provider_skeleton` package.
Checkout the available versions.

```
https://github.com/vicmoh/provider_skeleton
```

## Dart util package

You'll need `dart_util` package.
Checkout the available versions.

```
https://github.com/vicmoh/dart_util
```

## Pub GitHub dependencies

Go to `pubspec.yml` in the root folder, insert dependency below.

```
dependencies:
  flutter_components:
    git:
      url: git://github.com/vicmoh/flutter_components.git
      ref: v0.0.51

  # Used for the main architect framework.
  provider_skeleton:
    git:
      url: git://github.com/vicmoh/provider_skeleton.git
      ref: v0.0.24

  # Custom dart util
  dart_util:
    git:
      url: git://github.com/vicmoh/dart_util.git
      ref: v0.0.13
```
