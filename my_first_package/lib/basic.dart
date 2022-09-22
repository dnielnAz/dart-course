import 'package:equatable/equatable.dart';

class CustomType {
  final String value;

  CustomType(this.value);

  CustomType operator +(CustomType other) {
    return CustomType("$value ${other.value}");
  }

  @override
  String toString() {
    return value;
  }
}

class CustomFunction {
  void call() {
    print('10 / 0 is infinity: ${10 / 0}');
  }
}

class NumberUtils {
  void clamp() {
    print('Returns nearest number in a range based on a number');
    int number = 5;

    print('Number $number');
    print('clamp(10, 100) ${number.clamp(10, 100)}');
  }

  void round() {
    double toRound = 5.6;

    print('Round down ${toRound.floor()}');
    print('Round up ${toRound.ceil()}');
    print('Round ${toRound.round()}');
  }
}

class SpecialEquals extends Equatable {
  final int x;
  final int y;

  SpecialEquals(this.x, this.y);

  @override
  List<Object?> get props {
    return [x, y];
  }
}

class ListUtils {
  List<String> strings = const ["A", "B"]; // Unmodifiable

  void nulls() {
    print('Safe spread operator to prevent merging nullable lists');

    List<int> list1 = [1, 2, 3];
    List<int>? list2;

    print('${[...list1, ...?list2]}');
  }
}

class ExceptionsUtils {
  void catching(String value) {
    try {
      int.parse(value);
    } on FormatException {
      print('Not a number');
    } catch (error) {
      print('Unknown error');
      // rethrow; Pass the error
    } finally {
      print('End of program');
    }
  }
}
