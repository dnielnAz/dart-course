class Tuple<E extends num> {
  final E _a;
  final E _b;
  final E _c;

  E get first => _a;

  E get second => _b;

  E get third => _c;

  Tuple(this._a, this._b, this._c);
}

class ListUtils {
  static T? getItemOrNull<T>(List<T> list, int index) {
    T? obtained;

    if (list.asMap().containsKey(index)) {
      obtained = list[index];
    }

    return obtained;
  }
}
