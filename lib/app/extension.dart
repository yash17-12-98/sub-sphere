const empty = "";
const zero = 0;

// extension on String
extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return empty;
    } else {
      return this!;
    }
  }
}

// extension on Integer
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    } else {
      return this!;
    }
  }
}

// extension on List
extension NonNullList on List? {
  List orEmpty() {
    if (this == null) {
      return [];
    } else {
      return this!;
    }
  }
}

//extension on removing null value from map
extension MapNullValue on Map<String, dynamic> {
  Map<String, dynamic> removeNullValue() {
    return this..removeWhere((key, value) => value == null || value == '');
  }
}

// extension on bool
extension NonNullBoolean on bool? {
  bool orFalse() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}
