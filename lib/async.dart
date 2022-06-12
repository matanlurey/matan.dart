/// A set of extension methods and classes associated with `dart:async`.
///
/// This package intentionally does not import, attempt parity, or otherwise
/// defer to [`package:async`](https://pub.dev/packages/async) or related
/// packages, these are my own personalized preferences without additional
/// dependencies.
library matan.async;

/// Utility extensions on [Future].
extension FutureX<T> on Future<T> {
  /// Handles errors emitted by this [Future].
  ///
  /// Semantically, this is identical to calling [catchError].
  ///
  /// ... except that the type signature of [onError] is strengthened. For
  /// historic reasons, the original type signature accepts functions that
  /// will always throw at runtime or have unexpected behavior.
  Future<T> catchErrorOnly(
    void Function(Object? error) onError, {
    bool Function(Object error)? test,
  }) {
    return catchError(onError, test: test);
  }

  /// Handles errors, and provides the stack trace emitted by this [Future].
  ///
  /// This is identical to calling:
  /// ```
  /// future.catchError(onError);
  /// ```
  ///
  /// ... except that the type signature of [onError] is strengthened. For
  /// historic reasons, the original type signature accepts functions that
  /// will always throw at runtime or have unexpected behavior.
  Future<T> catchTrace(
    void Function(Object? error, StackTrace trace) onError, {
    bool Function(Object error)? test,
  }) {
    return catchError(onError, test: test);
  }
}
