import 'package:matan/railway.dart';
import 'package:test/test.dart';

void main() {
  group('Or2', () {
    late Or2<String, DateTime> or2;

    test('should pick 1', () {
      or2 = const Or2.e1('Test');
      expect(or2.pick((a) => 1, (b) => 2), 1);
    });

    test('should pick 2', () {
      or2 = Or2.e2(DateTime.now());
      expect(or2.pick((a) => 1, (b) => 2), 2);
    });

    test('should invoke orElse', () {
      or2 = const Or2.e1('Test');
      expect(or2.pickOrElse(orElse: () => 3), 3);
    });

    test('should throw an error', () {
      or2 = const Or2.e1('Test');
      expect(() => or2.pickOrElseThrows<Never>(), throwsStateError);
    });
  });

  group('Or3', () {
    // ignore: prefer_void_to_null
    late Or3<String, DateTime, Null> or3;

    test('should pick 1', () {
      or3 = const Or3.e1('Test');
      expect(or3.pick((a) => 1, (b) => 2, (c) => 3), 1);
    });

    test('should pick 2', () {
      or3 = Or3.e2(DateTime.now());
      expect(or3.pick((a) => 1, (b) => 2, (c) => 3), 2);
    });

    test('should pick 3', () {
      or3 = const Or3.e3(null);
      expect(or3.pick((a) => 1, (b) => 2, (c) => 3), 3);
    });

    test('should invoke orElse', () {
      or3 = const Or3.e1('Test');
      expect(or3.pickOrElse(orElse: () => 3), 3);
    });

    test('should throw an error', () {
      or3 = const Or3.e1('Test');
      expect(() => or3.pickOrElseThrows<Never>(), throwsStateError);
    });
  });
}
