import 'package:meta/meta.dart';

Never _elseThrows() => throw StateError('No matching expression');

/// Represents a value that be one of either elements `{A, B}`.
///
/// Typical usage is [pick], though [pickOrElse] provides some flexibility.
@immutable
@sealed
abstract class Or2<A, B> {
  const Or2._();

  /// A result of element [A].
  const factory Or2.e1(A a) = _Or2A;

  /// A result of element [B].
  const factory Or2.e2(B b) = _Or2B;

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// ```dart
  /// void example(Or2<String, DateTime> nameOrDate) {
  ///   print(nameOrDate.pick(
  ///     (a) => 'Name: $a',
  ///     (b) => 'Time: $b',
  ///   ));
  /// }
  /// ```
  R pick<R>(
    R Function(A a) if1,
    R Function(B a) if2,
  );

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Invokes [orElse] if none of the provided methods are invoked.
  R pickOrElse<R>({
    required R Function() orElse,
    R Function(A a)? if1,
    R Function(B b)? if2,
  }) {
    R ifElse(void _) => orElse();
    return pick(
      if1 ?? ifElse,
      if2 ?? ifElse,
    );
  }

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Throws an error (which should not happen in well-behavived system) if
  /// none of the provided methods are invoked. This should only be used instead
  /// of [pickOrElse] in as a form of self-documenting code ("this can only
  /// ever be a certain element").
  R pickOrElseThrows<R>({
    R Function(A a)? if1,
    R Function(B b)? if2,
  }) {
    return pickOrElse(
      orElse: _elseThrows,
      if1: if1,
      if2: if2,
    );
  }
}

class _Or2A<A, B> extends Or2<A, B> {
  final A _value;

  const _Or2A(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
  ) =>
      if1(_value);
}

class _Or2B<A, B> extends Or2<A, B> {
  final B _value;

  const _Or2B(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
  ) =>
      if2(_value);
}

/// Represents a value that be one of either elements `{A, B, C}`.
///
/// Typical usage is [pick], though [pickOrElse] provides some flexibility.
@immutable
@sealed
abstract class Or3<A, B, C> {
  const Or3._();

  /// A result of element [A].
  const factory Or3.e1(A a) = _Or3A;

  /// A result of element [B].
  const factory Or3.e2(B b) = _Or3B;

  /// A result of element [C].
  const factory Or3.e3(C c) = _Or3C;

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// ```dart
  /// void example(Or3<String, DateTime, Null> nameOrDateOrNull) {
  ///   print(nameOrDate.pick(
  ///     (a) => 'Name: $a',
  ///     (b) => 'Time: $b',
  ///     (c) => 'Nothing',
  ///   ));
  /// }
  /// ```
  R pick<R>(
    R Function(A a) if1,
    R Function(B b) if2,
    R Function(C c) if3,
  );

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Invokes [orElse] if none of the provided methods are invoked.
  R pickOrElse<R>({
    required R Function() orElse,
    R Function(A a)? if1,
    R Function(B b)? if2,
    R Function(C c)? if3,
  }) {
    R ifElse(void _) => orElse();
    return pick(
      if1 ?? ifElse,
      if2 ?? ifElse,
      if3 ?? ifElse,
    );
  }

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Throws an error (which should not happen in well-behavived system) if
  /// none of the provided methods are invoked. This should only be used instead
  /// of [pickOrElse] in as a form of self-documenting code ("this can only
  /// ever be a certain element").
  R pickOrElseThrows<R>({
    R Function(A a)? if1,
    R Function(B b)? if2,
    R Function(C c)? if3,
  }) {
    return pickOrElse(
      orElse: _elseThrows,
      if1: if1,
      if2: if2,
      if3: if3,
    );
  }
}

class _Or3A<A, B, C> extends Or3<A, B, C> {
  final A _value;

  const _Or3A(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
  ) =>
      if1(_value);
}

class _Or3B<A, B, C> extends Or3<A, B, C> {
  final B _value;

  const _Or3B(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
  ) =>
      if2(_value);
}

class _Or3C<A, B, C> extends Or3<A, B, C> {
  final C _value;

  const _Or3C(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
  ) =>
      if3(_value);
}

/// Represents a value that be one of either elements `{A, B, C, D}`.
///
/// Typical usage is [pick], though [pickOrElse] provides some flexibility.
@immutable
@sealed
abstract class Or4<A, B, C, D> {
  const Or4._();

  /// A result of element [A].
  const factory Or4.e1(A a) = _Or4A;

  /// A result of element [B].
  const factory Or4.e2(B b) = _Or4B;

  /// A result of element [C].
  const factory Or4.e3(C c) = _Or4C;

  /// A result of element [D].
  const factory Or4.e4(D d) = _Or4D;

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// ```dart
  /// void example(Or3<String, DateTime, int, Null> nameOrDateOrNull) {
  ///   print(nameOrDate.pick(
  ///     (a) => 'Name: $a',
  ///     (b) => 'Time: $b',
  ///     (c) => 'Number: $c',
  ///     (d) => 'Nothing',
  ///   ));
  /// }
  /// ```
  R pick<R>(
    R Function(A a) if1,
    R Function(B b) if2,
    R Function(C c) if3,
    R Function(D d) if4,
  );

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Invokes [orElse] if none of the provided methods are invoked.
  R pickOrElse<R>({
    required R Function() orElse,
    R Function(A a)? if1,
    R Function(B b)? if2,
    R Function(C c)? if3,
    R Function(D d)? if4,
  }) {
    R ifElse(void _) => orElse();
    return pick(
      if1 ?? ifElse,
      if2 ?? ifElse,
      if3 ?? ifElse,
      if4 ?? ifElse,
    );
  }

  /// Given the state of the value, invokes one of the provided methods.
  ///
  /// Throws an error (which should not happen in well-behavived system) if
  /// none of the provided methods are invoked. This should only be used instead
  /// of [pickOrElse] in as a form of self-documenting code ("this can only
  /// ever be a certain element").
  R pickOrElseThrows<R>({
    R Function(A a)? if1,
    R Function(B b)? if2,
    R Function(C c)? if3,
    R Function(D d)? if4,
  }) {
    return pickOrElse(
      orElse: _elseThrows,
      if1: if1,
      if2: if2,
      if3: if3,
      if4: if4,
    );
  }
}

class _Or4A<A, B, C, D> extends Or4<A, B, C, D> {
  final A _value;

  const _Or4A(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
    R Function(D) if4,
  ) =>
      if1(_value);
}

class _Or4B<A, B, C, D> extends Or4<A, B, C, D> {
  final B _value;

  const _Or4B(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
    R Function(D) if4,
  ) =>
      if2(_value);
}

class _Or4C<A, B, C, D> extends Or4<A, B, C, D> {
  final C _value;

  const _Or4C(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
    R Function(D) if4,
  ) =>
      if3(_value);
}

class _Or4D<A, B, C, D> extends Or4<A, B, C, D> {
  final D _value;

  const _Or4D(this._value) : super._();

  @override
  R pick<R>(
    R Function(A) if1,
    R Function(B) if2,
    R Function(C) if3,
    R Function(D) if4,
  ) =>
      if4(_value);
}
