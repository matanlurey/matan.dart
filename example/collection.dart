// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:matan/collection.dart';

void main() {
  print([1, 2, 3].containsExactly([1, 2, 3]));
  ImmutableList.of(1, 2, 3);
  ImmutableList([1, 2, 3]);
  ImmutableListBuilder<int>().add(1).addAll([2, 3]).build();
}
