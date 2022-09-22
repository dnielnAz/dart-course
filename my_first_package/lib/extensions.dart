extension IntegerExtensions on int {
  int get negative => (this * -1);

  int makeItDouble(bool makeNegative) {
    if (this == 0) {
      return 0;
    }

    if (this < 0) {
      return this * 2;
    }

    if (makeNegative) {
      return (this * 2) * -1;
    } else {
      return this * 2;
    }
  }
}
