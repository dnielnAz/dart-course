import 'package:calculator/utilities/utilities.dart';
import 'package:my_first_package/extensions.dart';

void main(List<String> arguments) {
  // SpecialEquals equals1 = SpecialEquals(1, 1);
  // SpecialEquals equals2 = SpecialEquals(1, 1);
  //
  // print('2 different objects with same values are equal: ${equals1 == equals2}');

  int testExtensions = 20;
  print('${testExtensions.negative}');
  print('${testExtensions.makeItDouble(false)}');


  Utilities();
}
