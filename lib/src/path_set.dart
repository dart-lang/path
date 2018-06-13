// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import '../path.dart' as p;

/// A set containing paths, compared using [equals] and [hash].
class PathSet extends IterableBase<String> implements Set<String> {
  /// The set to which we forward implementation methods.
  final Set<String> _inner;

  /// Creates an empty [PathSet] whose contents are compared using
  /// `context.equals` and `context.hash`.
  ///
  /// The [context] defaults to the current path context.
  PathSet({p.Context context}) : _inner = _create(context);

  /// Creates a [PathSet] with the same contents as [other] whose elements are
  /// compared using `context.equals` and `context.hash`.
  ///
  /// The [context] defaults to the current path context. If multiple elements
  /// in [other] represent the same logical path, the first value will be
  /// used.
  PathSet.of(Iterable<String> other, {p.Context context})
      : _inner = _create(context)..addAll(other);

  /// Creates a set that uses [context] for equality and hashing.
  static Set<String> _create(p.Context context) {
    context ??= p.context;
    return new LinkedHashSet(
        equals: (path1, path2) {
          if (path1 == null) return path2 == null;
          if (path2 == null) return false;
          return context.equals(path1, path2);
        },
        hashCode: (path) => path == null ? 0 : context.hash(path),
        isValidKey: (path) => path is String || path == null);
  }

  // Normally we'd use DelegatingSetView from the collection package to
  // implement these, but we want to avoid adding dependencies from path because
  // it's so widely used that even brief version skew can be very painful.

  Iterator<String> get iterator => _inner.iterator;

  int get length => _inner.length;

  bool add(String value) => _inner.add(value);

  void addAll(Iterable<String> elements) => _inner.addAll(elements);

  Set<T> cast<T>() => _inner.cast<T>();

  void clear() => _inner.clear();

  bool contains(Object other) => _inner.contains(other);

  bool containsAll(Iterable<Object> other) => _inner.containsAll(other);

  Set<String> difference(Set<Object> other) => _inner.difference(other);

  Set<String> intersection(Set<Object> other) => _inner.intersection(other);

  String lookup(Object element) => _inner.lookup(element);

  bool remove(Object value) => _inner.remove(value);

  void removeAll(Iterable<Object> elements) => _inner.removeAll(elements);

  void removeWhere(bool test(String element)) => _inner.removeWhere(test);

  void retainAll(Iterable<Object> elements) => _inner.retainAll(elements);

  void retainWhere(bool test(String element)) => _inner.retainWhere(test);

  Set<String> union(Set<String> other) => _inner.union(other);

  Set<String> toSet() => _inner.toSet();
}
