/// A set of extension methods and classes associated with `dart:collection`.
///
/// This package intentionally does not import, attempt parity, or otherwise
/// defer to [`package:collection`](https://pub.dev/packages/collection) or
/// related packages, these are my own personalized preferences without
/// additional dependencies.
library matan.collection;

import 'dart:collection';

import 'package:meta/dart2js.dart' as dart2js;
import 'package:meta/meta.dart';

part 'src/collection/immutable/collection.dart';
part 'src/collection/immutable/list.dart';
part 'src/collection/immutable/list_impl.dart';

/// Utility extensions on [Iterable].
extension IterableX<T> on Iterable<T> {
  static bool _equalityTest(Object? a, Object? b) => a == b;

  /// Returns whether [other]'s elements are all included in this collection.
  ///
  /// Equality of elements is implemented by `==` test by default for [equals].
  ///
  /// Note that duplicate elements in [other] are _not_ considered:
  /// ```
  /// [1, 2, 3].containsAll([2, 3, 3]) // true
  /// ```
  ///
  /// **IMPORTANT**: This function is intentionally _generic_ over _performant_;
  /// when [other]'s size grows to a non-trivial size, it is recommended to roll
  /// your own implementation based on the semantics of your collections.
  bool containsAll(
    Iterable<T> other, {
    bool Function(Object?, Object?) equals = _equalityTest,
  }) {
    if (identical(this, other)) {
      return true;
    }
    for (final element in other) {
      if (!contains(element)) {
        return false;
      }
    }
    return true;
  }

  /// Returns whether [other] has the same elements in the same positions.
  ///
  /// Equality of elements is implemented by `==` test by default for [equals].
  bool containsExactly(
    Iterable<T> other, {
    bool Function(Object?, Object?) equals = _equalityTest,
  }) {
    if (identical(this, other)) {
      return true;
    }
    final self = this;
    if (self is List<T> && other is List<T>) {
      // Optimization for <List>.containsExactly(<List>).
      // (Avoids allocating two iterators)
      if (length != other.length) {
        return false;
      }
      for (var i = 0; i < length; i++) {
        if (!equals(self[i], other[i])) {
          return false;
        }
      }
    } else {
      final a = iterator;
      final b = other.iterator;
      while (a.moveNext()) {
        if (!b.moveNext() || !equals(a.current, b.current)) {
          return false;
        }
      }
      if (b.moveNext()) {
        return false;
      }
    }
    return true;
  }
}
