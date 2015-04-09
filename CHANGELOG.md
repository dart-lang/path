## 1.3.5

* Added type annotations to top-level and static fields.

## 1.3.4

* Fix dev_compiler warnings.

## 1.3.3

* Performance improvement in `Context.relative` - don't call `current` if `from`
  is not relative.

## 1.3.2

* Fix some analyzer hints.

## 1.3.1

* Add a number of performance improvements.

## 1.3.0

* Expose a top-level `context` field that provides access to a `Context` object
  for the current system.

## 1.2.3

* Don't cache path Context based on cwd, as cwd involves a system-call to
  compute.

## 1.2.2

* Remove the documentation link from the pubspec so this is linked to
  pub.dartlang.org by default.

# 1.2.1

* Many members on `Style` that provided access to patterns and functions used
  internally for parsing paths have been deprecated.

* Manually parse paths (rather than using RegExps to do so) for better
  performance.

# 1.2.0

* Added `path.prettyUri`, which produces a human-readable representation of a
  URI.

# 1.1.0

* `path.fromUri` now accepts strings as well as `Uri` objects.
