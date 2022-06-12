import 'package:matan/async.dart';
import 'package:test/test.dart';

void main() {
  group('Future', () {
    test('catchErrorsOnly should pass-through to catchError', () {
      final thrown = _IntentionalError();
      Future<void>.error(thrown).catchErrorOnly(expectAsync1((error) {
        expect(
          error,
          thrown,
          reason: 'Error caught should be identical to the one thrown',
        );
      }));
    });

    test('catchTrace should pass-through to catchError', () {
      final thrown = _IntentionalError();
      final thrownTrace = StackTrace.current;
      Future<void>.error(thrown, thrownTrace).catchTrace(expectAsync2((
        error,
        trace,
      ) {
        expect(
          error,
          thrown,
          reason: 'Error caught should be identical to the one thrown',
        );
        expect(
          trace,
          thrownTrace,
          reason: 'Stack trace caught should be identical to one thrown',
        );
      }));
    });
  });
}

class _IntentionalError extends Error {}
