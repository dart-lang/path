// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:path/path.dart';

void main() {
  group("considers equal", () {
    test("two identical paths", () {
      var map = new PathMap<int>();
      map[join("foo", "bar")] = 1;
      map[join("foo", "bar")] = 2;
      expect(map, hasLength(1));
      expect(map, containsPair(join("foo", "bar"), 2));
    });

    test("two logically equivalent paths", () {
      var map = new PathMap<int>();
      map["foo"] = 1;
      map[absolute("foo")] = 2;
      expect(map, hasLength(1));
      expect(map, containsPair("foo", 2));
      expect(map, containsPair(absolute("foo"), 2));
    });

    test("two nulls", () {
      var map = new PathMap<int>();
      map[null] = 1;
      map[null] = 2;
      expect(map, hasLength(1));
      expect(map, containsPair(null, 2));
    });
  });

  group("considers unequal", () {
    test("two distinct paths", () {
      var map = new PathMap<int>();
      map["foo"] = 1;
      map["bar"] = 2;
      expect(map, hasLength(2));
      expect(map, containsPair("foo", 1));
      expect(map, containsPair("bar", 2));
    });

    test("a path and null", () {
      var map = new PathMap<int>();
      map["foo"] = 1;
      map[null] = 2;
      expect(map, hasLength(2));
      expect(map, containsPair("foo", 1));
      expect(map, containsPair(null, 2));
    });
  });

  test("uses the custom context", () {
    var map = new PathMap<int>(context: windows);
    map["FOO"] = 1;
    map["foo"] = 2;
    expect(map, hasLength(1));
    expect(map, containsPair("fOo", 2));
  });

  group(".of()", () {
    test("copies the existing map's keys", () {
      var map = new PathMap.of({"foo": 1, "bar": 2});
      expect(map, hasLength(2));
      expect(map, containsPair("foo", 1));
      expect(map, containsPair("bar", 2));
    });

    test("uses the second value in the case of duplicates", () {
      var map = new PathMap.of({"foo": 1, absolute("foo"): 2});
      expect(map, hasLength(1));
      expect(map, containsPair("foo", 2));
      expect(map, containsPair(absolute("foo"), 2));
    });
  });
}
