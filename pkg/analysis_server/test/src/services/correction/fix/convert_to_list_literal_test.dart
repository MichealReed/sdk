// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analysis_server/src/services/correction/fix.dart';
import 'package:analysis_server/src/services/linter/lint_names.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'fix_processor.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(ConvertToListLiteralTest);
  });
}

@reflectiveTest
class ConvertToListLiteralTest extends FixProcessorLintTest {
  @override
  FixKind get kind => DartFixKind.CONVERT_TO_LIST_LITERAL;

  @override
  String get lintCode => LintNames.prefer_collection_literals;

  Future<void> test_default_declaredType() async {
    await resolveTestUnit('''
List l = /*LINT*/List();
''');
    await assertHasFix('''
List l = [];
''');
  }

  Future<void> test_default_minimal() async {
    await resolveTestUnit('''
var l = /*LINT*/List();
''');
    await assertHasFix('''
var l = [];
''');
  }

  Future<void> test_default_newKeyword() async {
    await resolveTestUnit('''
var l = /*LINT*/new List();
''');
    await assertHasFix('''
var l = [];
''');
  }

  Future<void> test_default_tooManyArguments() async {
    await resolveTestUnit('''
var l = /*LINT*/List(5);
''');
    await assertNoFix();
  }

  Future<void> test_default_typeArg() async {
    await resolveTestUnit('''
var l = /*LINT*/List<int>();
''');
    await assertHasFix('''
var l = <int>[];
''');
  }
}
