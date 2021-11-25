import 'dart:io';

String fixture(String name) => File('test/unit-tests/trivia/fixture/$name')
    .readAsStringSync();