// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:path/path.dart';

void main() {
  group("considers equal", () {
    test("two identical paths", () {
      var set = PathSet();
      expect(set.add(join("foo", "bar")), isTrue);
      expect(set.add(join("foo", "bar")), isFalse);
      expect(set, hasLength(1));
      expect(set, contains(join("foo", "bar")));
    });

    test("two logically equivalent paths", () {
      var set = PathSet();
      expect(set.add("foo"), isTrue);
      expect(set.add(absolute("foo")), isFalse);
      expect(set, hasLength(1));
      expect(set, contains("foo"));
      expect(set, contains(absolute("foo")));
    });

    test("two nulls", () {
      var set = PathSet();
      expect(set.add(null), isTrue);
      expect(set.add(null), isFalse);
      expect(set, hasLength(1));
      expect(set, contains(null));
    });
  });

  group("considers unequal", () {
    test("two distinct paths", () {
      var set = PathSet();
      expect(set.add("foo"), isTrue);
      expect(set.add("bar"), isTrue);
      expect(set, hasLength(2));
      expect(set, contains("foo"));
      expect(set, contains("bar"));
    });

    test("a path and null", () {
      var set = PathSet();
      expect(set.add("foo"), isTrue);
      expect(set.add(null), isTrue);
      expect(set, hasLength(2));
      expect(set, contains("foo"));
      expect(set, contains(null));
    });
  });

  test("uses the custom context", () {
    var set = PathSet(context: windows);
    expect(set.add("FOO"), isTrue);
    expect(set.add("foo"), isFalse);
    expect(set, hasLength(1));
    expect(set, contains("fOo"));
  });

  group(".of()", () {
    test("copies the existing set's keys", () {
      var set = PathSet.of(["foo", "bar"]);
      expect(set, hasLength(2));
      expect(set, contains("foo"));
      expect(set, contains("bar"));
    });

    test("uses the first value in the case of duplicates", () {
      var set = PathSet.of(["foo", absolute("foo")]);
      expect(set, hasLength(1));
      expect(set, contains("foo"));
      expect(set, contains(absolute("foo")));
      expect(set.first, "foo");
    });
  });
}
