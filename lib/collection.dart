/// A set of extension methods and classes associated with `dart:collection`.
///
/// This package intentionally does not import, attempt parity, or otherwise
/// defer to [`package:collection`](https://pub.dev/packages/collection) or
/// related packages, these are my own personalized preferences without
/// additional ependencies.
library matan.collection;

import 'dart:collection';

import 'package:meta/meta.dart';

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

  /// Returns an [ImmutableList] containing the elements of this [Iterable].
  ///
  /// The elements are in iteration order.
  ImmutableList<T> toImmutableList() {
    final self = this;
    if (self is _ImmutableList<T>) {
      return _ImmutableList(self._list);
    }
    return ImmutableList.from(this);
  }
}

/// An indexable collection of objects with a length
///
/// Unlike [List], the list cannot be modified. See [copyWith].
@immutable
abstract class ImmutableList<T> implements Iterable<T> {
  /// Adapts [source] to be an `ImmutableList<T>`.
  ///
  /// Any time the list would produce an element that is not a [T], the element
  /// access will throw.
  ///
  /// If all accessed elements of [source] are actually instances of [T], and if
  /// all elements stored in the returned list are actually instance of [S],
  /// then the returned list can be used as an `ImmutableList<T>`.
  ///
  /// Methods which accept `Object?` as arguments, like [contains] will pass
  /// the arguemnt directly to this list's method without any checks.
  static ImmutableList<T> castFrom<S, T>(ImmutableList<S> source) {
    return _ImmutableList(List.castFrom((source as _ImmutableList<T>)._list));
  }

  /// Creates an immutable list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  factory ImmutableList(Iterable<T> elements) {
    return _ImmutableList(List.of(elements));
  }

  /// Creates a list containing all [elements].
  ///
  /// All the elements should be instances of [T].
  factory ImmutableList.from(Iterable<Object?> elements) {
    return _ImmutableList(List.from(elements));
  }

  /// Creates an immutable list from the provided parameters.
  ///
  /// Any value of `null` (whether explicit or implicit) is treated as the end
  /// of all parameters, and if any subsequent parameters are not null an error
  /// is thrown.
  static ImmutableList<T> of<T extends Object>([
    T? p0,
    T? p1,
    T? p2,
    T? p3,
    T? p4,
    T? p5,
    T? p6,
    T? p7,
    T? p8,
    T? p9,
  ]) {
    final output = <T>[];
    final input = [p0, p1, p2, p3, p4, p5, p6, p7, p8, p9];
    var i = 0;
    for (; i < input.length; i++) {
      final value = input[i];
      if (value != null) {
        output.add(value);
      } else {
        break;
      }
    }
    for (var n = i; n < input.length; n++) {
      if (input[n] != null) {
        throw StateError('Element $n was non-null after element $i was null');
      }
    }
    return _ImmutableList(output);
  }

  /// Generates an immutable list of values.
  ///
  /// See [List.generate].
  factory ImmutableList.generate(int length, T Function(int index) generator) {
    return _ImmutableList(List.generate(length, generator));
  }

  /// Returns the element at the provided [index].
  T operator [](int index);

  /// Returns a view of this list as an immutable list of [R] instances.
  ///
  /// See [ImmutableList.castFrom].
  @override
  ImmutableList<R> cast<R>();

  @override
  T elementAt(int index) => this[index];

  /// Creates an [Iterable] that iterates over a range of elements.
  ///
  /// See [List.getRange].
  Iterable<T> getRange(int start, int end);

  /// The first index of [element] in this list, or `-1` if not found.
  ///
  /// See [List.indexOf];
  int indexOf(T element, [int start = 0]);

  /// The first index in the lsit that satisfies the provided [test].
  ///
  /// See [List.indexWhere].
  int indexWhere(bool Function(T element) test, [int start = 0]);

  /// The last index of [element] in this list, or `-1` if not found.
  ///
  /// See [List.lastIndexOf];
  int lastIndexOf(T element, [int? start]);

  /// The first index in the lsit that satisfies the provided [test].
  ///
  /// See [List.lastIndexWhere].
  int lastIndexWhere(bool Function(T element) test, [int? start]);

  /// Returns the concatenation of this list and [other].
  @useResult
  ImmutableList<T> operator +(List<T> other);

  /// Returns a new list containing the elemnts between [start] and [end].
  ImmutableList<T> sublist(int start, [int? end]);

  /// Returns a new list with changes applied to the list provided to [mutate].
  ///
  /// ```dart
  /// ImmutableList<String> mutateExample(ImmutableList<String> names) {
  ///   return names.copyWith((names) => names.addAll(['Abe', 'Roy', 'Sam']));
  /// }
  /// ```
  ImmutableList<T> copyWith(void Function(List<T>) mutate);
}

class _ImmutableList<T> extends IterableBase<T> implements ImmutableList<T> {
  final List<T> _list;

  const _ImmutableList(this._list);

  @override
  ImmutableList<R> cast<R>() => ImmutableList(_list.cast());

  @override
  T get first => _list.first;

  @override
  T get last => _list.last;

  @override
  T operator [](int index) => _list[index];

  @override
  ImmutableList<T> operator +(List<T> other) => _ImmutableList(_list + other);

  @override
  Iterator<T> get iterator => _list.iterator;

  @override
  Iterable<T> getRange(int start, int end) => _list.getRange(start, end);

  @override
  int indexOf(T element, [int start = 0]) => _list.indexOf(element, start);

  @override
  int indexWhere(bool Function(T element) test, [int start = 0]) {
    return _list.indexWhere(test, start);
  }

  @override
  int lastIndexOf(T element, [int? start]) => _list.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(T element) test, [int? start]) {
    return _list.lastIndexWhere(test, start);
  }

  @override
  ImmutableList<T> sublist(int start, [int? end]) {
    return _ImmutableList(_list.sublist(start, end));
  }

  @override
  ImmutableList<T> copyWith(void Function(List<T>) mutate) {
    final list = List.of(_list);
    mutate(list);
    return _ImmutableList(List.of(list));
  }
}
