# CHANGELOG

## v2.0.0

### `async.dart`

Removed as `Future.catchError` is [handled by a hint](https://dart.dev/tools/diagnostic-messages#argument_type_not_assignable_to_error_handler).

This library is likely to be re-added at a future point in time.

### `collection.dart`

- Added `ImmutableCollection`, `ImmutableCollectionBuilder`.
- Added `ImmutableList`, `ImmutableListBuilder`.

### `convert.dart`

- Added `StructuredData`, `JsonStructuredData`, to help parse JSON-like data.

### `railway.dart`

- Added `Or2`, `Or3`, `Or4` as union-like classes for FP-like programming.

## v1.0.0

- Initial release, including:
  - `strict.yaml`, annoyingly opionated `analysis_options.yaml` settings
  - `async.dart`, extension methods to type `Future.catchError`
  - `collection.dart`, simple equality extensions on common collections
  - `railway.dart`, extension methods and classes for functional ROP.
