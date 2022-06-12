/// A set of extension methods and classes associated with `dart:convert`.
///
/// This package intentionally does not import, attempt parity, or otherwise
/// defer to [`package:convert`](https://pub.dev/packages/convert) or related
/// packages, these are my own personalized preferences without additional
/// dependencies.
library matan.convert;

import 'dart:convert';

import 'package:meta/meta.dart';

/// Represents a `Map<String, Object?>`, or a Dart encoded JSON object.
typedef JsonObject = Map<String, Object?>;

/// A class that allows reading fields based on a key.
@immutable
abstract class StructuredData<K> {
  // ignore: prefer_void_to_null
  static Null _alwaysNull(Object? _) => null;

  /// Returns a converter that reads from structured data when creating.
  ///
  /// ```dart
  /// StructuredData.converter<int, Animal>(
  ///   (reader) => Animal(reader.required(0), reader.optional(1)),
  /// )
  /// ```
  static Converter<StructuredData<K>, T> converter<K, T>(
    T Function(StructuredData<K>) reader,
  ) {
    return _StructuredDataConverter(reader);
  }

  // ignore: public_member_api_docs
  const StructuredData();

  /// Reads the field marked with [key], defaulting to [orElse] if omitted.
  ///
  /// If [converter] is provided, it is used before returning the final value.
  ///
  /// If [orElse] is not provided, and the field is missing, an error is thrown.
  T required<T>(
    K key, {
    Converter<StructuredData<K>, T>? converter,
    T Function(K key) orElse,
  });

  /// Reads the field marked with [key], default to [orElse] if omitted.
  ///
  /// If [orElse] is not provided, and the field is missing, null is returned.
  T? optional<T>(
    K key, {
    Converter<StructuredData<K>, T>? converter,
    T? Function(K key) orElse = _alwaysNull,
  }) {
    return required(key, converter: converter, orElse: orElse);
  }
}

/// A class that allows reading string-based fields from a [JsonObject].
@immutable
class JsonStructuredData extends StructuredData<String> {
  static Never _orElseThrow(String key) {
    throw ArgumentError.value(key, 'key', 'Not present in the JSON object');
  }

  /// Returns a converter that reads from JSON structured data when creating.
  ///
  /// ```dart
  /// StructuredData.converter<int, Animal>(
  ///   (reader) => Animal(reader.required('name'), reader.optional('color')),
  /// )
  /// ```
  static Converter<StructuredData<String>, T> converter<T>(
    T Function(StructuredData<String>) reader,
  ) {
    return StructuredData.converter(reader);
  }

  final JsonObject _json;

  // ignore: public_member_api_docs
  const JsonStructuredData(this._json);

  @override
  T required<T>(
    String key, {
    Converter<StructuredData<String>, T>? converter,
    T Function(String key) orElse = _orElseThrow,
  }) {
    var value = _json[key];
    if (value == null && !_json.containsKey(key)) {
      value = orElse(key);
    }
    if (value != null && converter != null) {
      final nested = JsonStructuredData(value as JsonObject);
      return converter.convert(nested);
    } else {
      return value as T;
    }
  }
}

class _StructuredDataConverter<K, T> extends Converter<StructuredData<K>, T> {
  final T Function(StructuredData<K>) _reader;

  const _StructuredDataConverter(this._reader);

  @override
  T convert(StructuredData<K> input) => _reader(input);
}
