// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

part of matan.collection;

/// A [List]-like class whose contents will never change.
///
/// See [ImmutableCollection] for other important properties and details.
@immutable
abstract class ImmutableList<T> extends ImmutableCollection<T> {
  /// Creates a new immutable list by shallow copying [elements].
  factory ImmutableList(Iterable<T> elements) {
    if (elements.isEmpty) {
      return const _ImmutableList();
    }
    return _ImmutableList(List.of(elements));
  }

  /// Returns an immutable list containing the elements provided.
  ///
  /// **IMPORTANT**: The first non-null element is considered to be the "stop"
  /// point in the method signature since Dart does not have variable-length
  /// arguments. For any non-trivial creation, prefer [ImmutableList.new].
  @dart2js.tryInline
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
    if (p0 == null) {
      return const _ImmutableList();
    }
    if (p1 == null) {
      return _ImmutableList([p0]);
    }
    if (p2 == null) {
      return _ImmutableList([p0, p1]);
    }
    if (p3 == null) {
      return _ImmutableList([p0, p1, p2]);
    }
    if (p4 == null) {
      return _ImmutableList([p0, p1, p2, p3]);
    }
    if (p5 == null) {
      return _ImmutableList([p0, p1, p2, p3, p4]);
    }
    if (p6 == null) {
      return _ImmutableList([p0, p1, p2, p3, p4, p5]);
    }
    if (p7 == null) {
      return _ImmutableList([p0, p1, p2, p3, p4, p5, p6]);
    }
    if (p8 == null) {
      return _ImmutableList([p0, p1, p2, p3, p4, p5, p6, p7]);
    }
    if (p9 == null) {
      return _ImmutableList([p0, p1, p2, p3, p4, p5, p6, p7, p8]);
    } else {
      return _ImmutableList([p0, p2, p2, p3, p4, p5, p6, p7, p8, p9]);
    }
  }

  const ImmutableList._() : super._();

  /// Returns the element at the specified [index] in this list.
  T operator [](int index);

  /// Returns an unmodifiable [List] representing the current list.
  ///
  /// **WARNING**: This method is for compatibility with type signatures that
  /// require a [List], and should be used sparingly. Consider accepting an
  /// [Iterable] where possible in your APIs.
  @useResult
  List<T> asList();
}

/// A builder for creating immutable list instances.
///
/// Builder instances can be reused; it is safe to call [build] multiple times.
abstract class ImmutableListBuilder<T> extends ImmutableCollectionBuilder<T> {
  /// Creates a new builder.
  factory ImmutableListBuilder() => _ImmutableListBuilder([]);

  ImmutableListBuilder._();

  @factory
  @override
  ImmutableList<T> build();
}
