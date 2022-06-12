// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:matan/convert.dart';
import 'package:meta/meta.dart';

void main() {
  final employee = _employeeReader.convert(JsonStructuredData({
    'name': 'Matan',
    'age': 33,
    'manager': {
      'name': 'Will',
      'age': 21,
    },
  }));
  print(employee);
}

final _employeeReader = JsonStructuredData.converter(
  (reader) => Employee(
    name: reader.required('name'),
    age: reader.required('age'),
    manager: reader.optional('manager', converter: _employeeReader),
  ),
);

/// An example of an immutable class created by its constructor.
@immutable
class Employee {
  /// Name of the employee.
  final String name;

  /// Age of the employee.
  final int age;

  /// Manager of the employee, if any.
  final Employee? manager;

  const Employee({
    required this.name,
    required this.age,
    this.manager,
  });

  @override
  String toString() {
    return 'Employee ${{
      'name': name,
      'age': age,
      'manager': manager,
    }}';
  }
}
