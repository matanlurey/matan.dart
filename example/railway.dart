// ignore_for_file: prefer_const_constructors

import 'package:matan/railway.dart';

void main() {
  print(Or2<String, DateTime>.e1('Hello World').pick(
    (a) => 'Message: $a',
    (b) => 'Date:    $b',
  ));
}
