import 'dart:collection';

import 'package:matan/collection.dart';
import 'package:test/test.dart';

void main() {
  group('IterableX', () {
    group('containsAll', () {
      test('should return true for the same iterable', () {
        final list = <void>[];
        expect(list.containsAll(list), isTrue);
      });

      test('should return true when all elements contained', () {
        expect([1, 2, 3].containsAll([2, 3]), isTrue);
        expect([1, 2, 3].containsAll([2, 3, 3]), isTrue);
      });

      test('should return false when missing an element', () {
        expect([1, 2, 3].containsAll([3, 4]), isFalse);
      });
    });

    group('containsExactly(list, list)', () {
      test('should return true for the same list', () {
        final list = <void>[];
        expect(list.containsExactly(list), isTrue);
      });

      test('should return true when all elements contained', () {
        expect([1, 2, 3].containsExactly([1, 2, 3]), isTrue);
      });

      test('should return false when missing an element', () {
        expect([1, 2, 3].containsExactly([1, 2, 3, 4]), isFalse);
      });

      test('should return false when elements are out of order', () {
        expect([1, 2, 3].containsExactly([1, 3, 2]), isFalse);
      });
    });

    group('containsExactly(list, iterable)', () {
      test('should return true when all elements contained', () {
        expect([1, 2, 3].containsExactly([1, 2, 3].asIterable()), isTrue);
      });

      test('should return false when missing an element', () {
        expect([1, 2, 3].containsExactly([1, 2, 3, 4].asIterable()), isFalse);
      });

      test('should return false when elements are out of order', () {
        expect([1, 2, 3].containsExactly([1, 3, 2].asIterable()), isFalse);
      });
    });
  });
}

extension _ListX<T> on List<T> {
  Iterable<T> asIterable() => _ListAsIterable(this);
}

class _ListAsIterable<T> extends IterableBase<T> {
  final List<T> _delegate;

  _ListAsIterable(this._delegate);

  @override
  Iterator<T> get iterator => _delegate.iterator;
}
