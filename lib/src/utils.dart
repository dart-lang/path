// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'characters.dart' as chars;

/// Returns whether [char] is the code for an ASCII letter (uppercase or
/// lowercase).
bool isAlphabetic(int char) =>
    (char >= chars.upperA && char <= chars.upperZ) ||
    (char >= chars.lowerA && char <= chars.lowerZ);

/// Returns whether [char] is the code for an ASCII digit.
bool isNumeric(int char) => char >= chars.zero && char <= chars.nine;

/// Returns whether [path] has a URL-formatted Windows drive letter beginning at
/// [index].
bool isDriveLetter(String path, int index) =>
    driveLetterEnd(path, index) != null;

/// Returns the index of the first character after the drive letter or a
/// URL-formatted path, or `null` if [index] is not the start of a drive letter.
/// A valid drive letter must be followed by a colon and then either a `/` or
/// the end of string.
///
/// ```
/// d:/abc => 3
/// d:/    => 3
/// d:     => 2
/// d      => null
/// ```
int? driveLetterEnd(String path, int index) {
  if (path.length < index + 2) return null;
  if (!isAlphabetic(path.codeUnitAt(index))) return null;
  if (path.codeUnitAt(index + 1) != chars.colon) {
    // If not a raw colon, check for escaped colon
    if (path.length < index + 4) return null;
    if (path.substring(index + 1, index + 4).toLowerCase() != '%3a') {
      return null;
    }
    // Offset the index to account for the extra 2 characters from the
    // colon encoding.
    index += 2;
  }
  if (path.length == index + 2) return index + 2;
  if (path.codeUnitAt(index + 2) != chars.slash) return null;
  return index + 3;
}
