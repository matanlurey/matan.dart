/// A simple command-line tool that generates an `analysis_options.yaml` file.
///
/// ```bash
/// $ dart tool/strict.dart
/// $ dart tool/strict.dart > lib/strict.yaml
/// ```
library matan.tool.strict;

import 'dart:io';

final lints = [
  // Error Rules
  const Lint('avoid_dynamic_calls', Severity.warning),
  const Lint('avoid_empty_else'),
  const Lint('avoid_relative_lib_imports'),
  const Lint('avoid_types_as_parameter_names', Severity.warning),
  const Lint('avoid_web_libraries_in_flutter', Severity.error),
  const Lint('comment_references'),
  const Lint('control_flow_in_finally'),
  const Lint('empty_statements'),
  const Lint('hash_and_equals', Severity.warning),
  const Lint('iterable_contains_unrelated_type', Severity.warning),
  const Lint('list_remove_unrelated_type', Severity.warning),
  const Lint('no_adjacent_strings_in_list'),
  const Lint('no_duplicate_case_values', Severity.warning),
  const Lint('no_logic_in_create_state', Severity.warning),
  const Lint('prefer_void_to_null', Severity.warning),
  const Lint('unnecessary_statements'),
  const Lint('unrelated_type_equality_checks', Severity.warning),
  const Lint('use_build_context_synchronously'),
  const Lint('use_key_in_widget_constructors'),
  const Lint('valid_regexps', Severity.warning),

  // Style Rules
  const Lint('always_put_required_named_parameters_first'),
  const Lint('annotate_overrides', Severity.warning),
  const Lint('avoid_bool_literals_in_conditional_expressions'),
  const Lint('avoid_catches_without_on_clauses'),
  const Lint('avoid_catching_errors'),
  const Lint('avoid_classes_with_only_static_members'),
  const Lint('avoid_double_and_int_checks'),
  const Lint('avoid_equals_and_hash_code_on_mutable_classes'),
  const Lint('avoid_escaping_inner_quotes'),
  const Lint('avoid_field_initializers_in_const_classes'),
  const Lint('avoid_final_parameters'),
  const Lint('avoid_function_literals_in_foreach_calls'),
  const Lint('avoid_implementing_value_types', Severity.warning),
  const Lint('avoid_init_to_null'),
  const Lint('avoid_js_rounded_ints', Severity.warning),
  const Lint('avoid_multiple_declarations_per_line'),
  const Lint('avoid_null_checks_in_equality_operators', Severity.warning),
  const Lint('avoid_positional_boolean_parameters'),
  const Lint('avoid_private_typedef_functions'),
  const Lint('avoid_redundant_argument_values'),
  const Lint('avoid_renaming_method_parameters'),
  const Lint('avoid_return_types_on_setters'),
  const Lint('avoid_returning_null_for_void'),
  const Lint('avoid_setters_without_getters'),
  const Lint('avoid_shadowing_type_parameters', Severity.warning),
  const Lint('avoid_single_cascade_in_expression_statements'),
  const Lint('avoid_types_on_closure_parameters'),
  const Lint('avoid_unnecessary_containers'),
  const Lint('avoid_unused_constructor_parameters'),
  const Lint('await_only_futures', Severity.warning),
  const Lint('camel_case_extensions', Severity.warning),
  const Lint('camel_case_types', Severity.warning),
  const Lint('cascade_invocations'),
  const Lint('cast_nullable_to_non_nullable'),
  const Lint('conditional_uri_does_not_exist'),
  const Lint('constant_identifier_names', Severity.warning),
  const Lint('curly_braces_in_flow_control_structures'),
  const Lint('deprecated_consistency'),
  const Lint('directives_ordering'),
  const Lint('do_not_use_environment'),
  const Lint('empty_catches', Severity.warning),
  const Lint('empty_constructor_bodies'),
  const Lint('exhaustive_cases', Severity.warning),
  const Lint('file_names', Severity.warning),
  const Lint('implementation_imports', Severity.warning),
  const Lint('library_names'),
  const Lint('library_prefixes'),
  const Lint('library_private_types_in_public_api'),
  const Lint('non_constant_identifier_names', Severity.warning),
  const Lint('noop_primitive_operations'),
  const Lint('null_check_on_nullable_type_parameter', Severity.warning),
  const Lint('null_closures', Severity.warning),
  const Lint('omit_local_variable_types'),
  const Lint('only_throw_errors', Severity.warning),
  const Lint('overridden_fields', Severity.warning),
  const Lint('package_api_docs'),
  const Lint('package_prefixed_library_names'),
  const Lint('parameter_assignments'),
  const Lint('prefer_adjacent_string_concatenation'),
  const Lint('prefer_asserts_with_message'),
  const Lint('prefer_collection_literals'),
  const Lint('prefer_conditional_assignment'),
  const Lint('prefer_const_constructors'),
  const Lint('prefer_const_constructors_in_immutables'),
  const Lint('prefer_const_declarations'),
  const Lint('prefer_const_literals_to_create_immutables'),
  const Lint('prefer_contains'),
  const Lint('prefer_equal_for_default_values'),
  const Lint('prefer_final_fields'),
  const Lint('prefer_final_in_for_each'),
  const Lint('prefer_final_locals'),
  const Lint('prefer_for_elements_to_map_fromIterable'),
  const Lint('prefer_function_declarations_over_variables'),
  const Lint('prefer_generic_function_type_aliases'),
  const Lint('prefer_if_null_operators'),
  const Lint('prefer_initializing_formals', Severity.warning),
  const Lint('prefer_inlined_adds'),
  const Lint('prefer_interpolation_to_compose_strings'),
  const Lint('prefer_is_empty'),
  const Lint('prefer_is_not_empty'),
  const Lint('prefer_is_not_operator'),
  const Lint('prefer_iterable_whereType', Severity.warning),
  const Lint('prefer_mixin', Severity.warning),
  const Lint('prefer_null_aware_operators'),
  const Lint('prefer_single_quotes'),
  const Lint('prefer_spread_collections'),
  const Lint('prefer_typing_uninitialized_variables', Severity.warning),
  const Lint('provide_deprecation_message', Severity.warning),
  const Lint('public_member_api_docs'),
  const Lint('recursive_getters', Severity.warning),
  const Lint('sized_box_for_whitespace'),
  const Lint('slash_for_doc_comments'),
  const Lint('sort_child_properties_last'),
  const Lint('type_init_formals'),
  const Lint('unawaited_futures', Severity.warning),
  const Lint('unnecessary_await_in_return'),
  const Lint('unnecessary_brace_in_string_interps'),
  const Lint('unnecessary_const'),
  const Lint('unnecessary_constructor_name'),
  const Lint('unnecessary_getters_setters'),
  const Lint('unnecessary_lambdas'),
  const Lint('unnecessary_late', Severity.warning),
  const Lint('unnecessary_new'),
  const Lint('unnecessary_null_aware_assignments'),
  const Lint('unnecessary_null_in_if_null_operators'),
  const Lint('unnecessary_overrides'),
  const Lint('unnecessary_parenthesis'),
  const Lint('unnecessary_raw_strings'),
  const Lint('unnecessary_string_escapes'),
  const Lint('unnecessary_string_interpolations'),
  const Lint('unnecessary_this'),
  const Lint('use_enums', Severity.warning),
  const Lint('use_full_hex_values_for_flutter_colors'),
  const Lint('use_function_type_syntax_for_parameters'),
  const Lint('use_named_constants'),
  const Lint('use_late_for_private_fields_and_variables'),
  const Lint('use_rethrow_when_possible'),
  const Lint('void_checks', Severity.warning),

  // Pub Rules
  const Lint('depend_on_referenced_packages', Severity.error),
  const Lint('package_names', Severity.error),
  const Lint('secure_pubspec_urls'),
  const Lint('sort_pub_dependencies'),
]..sort((a, b) => a.name.compareTo(b.name));

const languageRules = <String, Object?>{
  'strict-casts': true,
  'strict-inference': true,
  'strict-raw-types': true,
};

void main(List<String> args) {
  if (args.isNotEmpty) {
    stderr.writeln('Usage: dart tool/strict.dart');
    exit(1);
  }

  var spaces = 0;

  final output = StringBuffer();
  void write(String line) {
    output.writeln('${' ' * spaces}$line');
  }

  write('# AUTO-GENERATED. DO NOT EDIT. See tool/strict.dart');
  write('');

  write('analyzer:');

  spaces += 2;
  write('language:');

  spaces += 2;
  languageRules.forEach((name, value) {
    write('$name: $value');
  });
  spaces -= 2;

  write('errors:');
  spaces += 2;
  for (final lint in lints) {
    if (lint.severity != Severity.info) {
      write('${lint.name}: ${lint.severity.name}');
    }
  }
  spaces -= 2;

  spaces -= 2;
  write('');

  write('linter:');
  spaces += 2;
  write('rules:');
  spaces += 2;
  for (final lint in lints) {
    write('# https://dart-lang.github.io/linter/lints/${lint.name}');
    write('- ${lint.name}');
  }
  spaces -= 2;
  spaces -= 2;

  if (args.isEmpty) {
    stdout.write(output);
  }
}

class Lint {
  final String name;
  final Severity severity;

  const Lint(this.name, [this.severity = Severity.info]);
}

enum Severity {
  ignore,
  info,
  warning,
  error,
}
