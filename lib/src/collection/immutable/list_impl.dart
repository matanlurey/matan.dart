part of matan.collection;

/// Optimizations that replace [Iterable] methods with a pass-through to [List].
///
/// This could be inlined below, but would be harder to read and understand.
mixin _DelegatingList<T> implements Iterable<T> {
  List<T> get _list;

  @override
  bool contains(Object? element) => _list.contains(element);

  @override
  T get first => _list.first;

  @override
  T get last => _list.last;

  @override
  T elementAt(int index) => _list[index];

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  int get length => _list.length;
}

class _ImmutableList<T> extends ImmutableList<T> with _DelegatingList<T> {
  @override
  final List<T> _list;

  const _ImmutableList([this._list = const []]) : super._();

  @override
  T operator [](int index) => _list[index];

  @override
  int get hashCode => Object.hashAll(_list);

  @override
  bool operator ==(Object other) {
    return other is _ImmutableList<T> && containsAll(other._list);
  }

  @override
  @useResult
  ImmutableListBuilder<T> toBuilder() {
    return _ImmutableListBuilder(List.of(_list));
  }

  /// Returns an unmodifiable [List] representing the current list.
  ///
  /// **WARNING**: This method is for compatibility with type signatures that
  /// require a [List], and should be used sparingly. Consider accepting an
  /// [Iterable] where possible in your APIs.
  @override
  @useResult
  List<T> asList() => UnmodifiableListView(_list);

  @override
  Iterator<T> get iterator => _list.iterator;
}

class _ImmutableListBuilder<T> extends ImmutableListBuilder<T> {
  final List<T> _list;

  _ImmutableListBuilder(this._list) : super._();

  @override
  _ImmutableListBuilder<T> add(T element) {
    _list.add(element);
    return this;
  }

  @override
  _ImmutableListBuilder<T> addAll(Iterable<T> elements) {
    _list.addAll(elements);
    return this;
  }

  @override
  ImmutableList<T> build() => _ImmutableList(_list);
}
