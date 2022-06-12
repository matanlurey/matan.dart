# matan.dart

The personal Dart package of <https://github.com/matanlurey>.

[![Binary on pub.dev][pub_img]][pub_url]
[![Code coverage][cov_img]][cov_url]
[![Github action status][gha_img]][gha_url]
[![Dartdocs][doc_img]][doc_url]
[![Style guide][sty_img]][sty_url]

[pub_url]: https://pub.dev/packages/matan
[pub_img]: https://img.shields.io/pub/v/matan.svg
[gha_url]: https://github.com/matanlurey/matan.dart/actions
[gha_img]: https://github.com/matanlurey/matan.dart/workflows/Dart/badge.svg
[cov_url]: https://codecov.io/gh/matanlurey/matan.dart
[cov_img]: https://codecov.io/gh/matanlurey/matan.dart/branch/main/graph/badge.svg
[doc_url]: https://pub.dev/documentation/matan/latest
[doc_img]: https://img.shields.io/badge/Documentation-matan-blue.svg
[sty_url]: https://pub.dev/packages/matan
[sty_img]: https://img.shields.io/badge/style-matan-9cf.svg

This package contains code and configuration that I find myself wanting whenever
working with Dart, but I don't want to bother publishing a more proper set of
packages. If anything in this package grows too much in scope, it's a candidate
for another package.

**This package will never contain any non-dev depdencies.**

## Installation

_Once upon a time the package manager was just `pub`, and I didn't have to add
instructions._

```bash
dart pub add matan
```

Or when writing a Flutter app or package:

```bash
flutter pub add matan
```

If you _only_ use `strict.yaml`, depend on this package as a _dev_ dependency:

```bash
dart pub add matan --dev
```

### Versioning

This package follows **strict** [semantic versioning](https://semver.org/):

1. The MAJOR version is updated on any incompatible API change or lint change
2. The MINOR version is updated when functionality is added
3. The PATCH version is updated when bug fixes are made

However, if `strict.yaml` adds a _new_ lint or modifies a setting that issues
an informational message (not warnings or errors), it is considered a _minor_
update. If your build will fail on additional `info` diagnostic messages
it is recommended _not_ to use `strict.yaml`.

## Usage

See <https://pub.dev/documentation/matan/latest/>.

_Unless otherwise specified_, this package is intended to be an **implementation
detail**; in other words, try not to return types declared in Dart libraries as
part of your external/public API of your own package:

```dart
library my.library;

import 'package:matan/example.dart' show Example;

// BAD: Apps/packages that use your package are tighly bound on this package.
Example myFunction() => Example();
```

```dart
library my.library;

import 'package:matan/example.dart' show Example;

// GOOD: Dependencies of your package won't need to import this package.
YourOwnThing myFuncion() => YourOwnThing();

class YourOwnThing {
  // Keep this private, if it was public then again the type would leak out.
  final _delegate = Example();
}
```

### Linting

In your
[`analysis_options.yaml`](https://dart.dev/guides/language/analysis-options)
file, include:

```yaml
include: package:matan/strict.yaml
```

I use the following rules when assigning severities:

- _info_: Provides stylistic consistentcy or avoids possible mistakes.
- _warning_: Makes your public API or implementaton safer; rare ignores are OK.
- _error_: This should never appear in your code and do not ignore it.

Of course, it's subjective not objective. Feel free to send a pull request.
