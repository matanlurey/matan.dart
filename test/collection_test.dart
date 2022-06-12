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

  group('ImmutableList', () {
    test('should copy a list of elements', () {
      final copy = [1, 2, 3];
      final list = ImmutableList(copy);
      expect(list, containsAllInOrder([1, 2, 3]));

      copy.clear();
      expect(list, containsAllInOrder([1, 2, 3]));
    });

    group('should create a new list with', () {
      for (var i = 0; i < 10; i++) {
        test('$i parameters', () {
          // This is not a good way to use .of, but it is easier to test.
          final input = List.generate(i, (i) => i);
          final list = Function.apply(ImmutableList.of, input) as ImmutableList;
          if (i == 0) {
            expect(list, isEmpty);
          } else {
            expect(list, containsAllInOrder(input));
          }
        });
      }
    });

    test('should provide [] access', () {
      expect(ImmutableList.of(1)[0], 1);
    });

    test('should provide compatibility with List', () {
      final list = ImmutableList.of(1, 2, 3).asList();
      expect(list, containsAllInOrder([1, 2, 3]));
      expect(() => list.add(4), throwsUnsupportedError);
    });

    test('should provide shallow equality semantics', () {
      final a = ImmutableList.of(1, 2, 3);
      final b = ImmutableList.of(1, 2, 3);
      expect(a, equals(b));
      expect(a.hashCode, b.hashCode);
    });

    test('should provide mutation through builders', () {
      final list = ImmutableListBuilder<int>().add(1).addAll([2, 3]).build();
      expect(list, containsAllInOrder([1, 2, 3]));
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
